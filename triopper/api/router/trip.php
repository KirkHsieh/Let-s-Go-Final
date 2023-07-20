<?php

//TODO
/**
 * draft on retrieve : search can't see draft,trip_id can but need host
 *      on delete : first cond : isdraft => can be delete; second cond : endDate exceeded => it can't be delete
 */

$trip_con->register("create",function($data){

    /**
     * def:(token,dataset):status //permission > 0
     */

    //[check]inputs
    if(!isset($data->token,$data->dataset))
        return status(INVAILD_INPUT);
    if(!checkType("so",$data->token,$data->dataset))
        return status(INVAILD_INPUT);

    //[login]
    $auth = new FB_auth($data->token);
    $uc = new User();
    $user = $uc->user_exists($auth,['level','user_id']);
    if(!$user)
        return status(USER_NOT_EXISTS);

    $user_data = $user->fetch_assoc();

    //[check]level
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);
    

    $required_item = ['name'=>'s','place'=>'s','context'=>'s','startDate'=>'s','endDate'=>'s','attendable'=>'b','isDraft'=>'b','plimit'=>'i'];
    $optional_item = ['tag'=>'a','photo'=>'s'];
    try{
        $dataset = new Dataset(array_merge($required_item,$optional_item),(array)$data->dataset);
        
        $dataset->rebuild(array_keys($required_item),array_keys($optional_item));
        $dataset->add("rank",0);
        $done = $dataset->apply($store,function($key,$value){
            switch($key){
                case 'name':
                case 'place':
                case 'photo':
                    $text = new Text($value);
                    $text->remove_tags([],[]);
                    $text->trim();
                    return $text->toString();
                case 'context':
                    $text = new Text($value);
                    $text->remove_tags(['p','div','h1','span','a','img'],['href','style']);
                    $text->trim();
                    return $text->toString();
                case 'startDate':
                case 'endDate':
                    try{
                        $time = new DatetimeText($value);
                        $time->format("YmdHis");
                        return $time->toString();
                    }catch(InternalException $e){
                        return false;
                    }
                case 'tag':
                    if(array_unique(array_map(function($item){return preg_match("/^[\w\p{Han}]$/");},$value)) !== [true])
                        return false;
                default:
                    return $value;
            }
        });
        if(!$done)
            return status(INVAILD_INPUT);

        $startDate = strtotime($dataset->get('startDate'));
        $endDate = strtotime($dataset->get('endDate'));
        if($startDate <= time() || $startDate > $endDate)
            return status(INVAILD_INPUT);

    }catch(InternalException $e){
        return status(INVAILD_INPUT);
    }

    $tc = new Trip();
    $ac = new Attender();
    $tc->create($dataset->toAssoc());
    $ac->create(['trip_id'=>$tc['ínsert_id'],'user_id'=>$user_data['user_id'],'relationship'=>2]);
    return status(SUCCESS);
});

$trip_con->register("retrieve",function($data){

    /*
     * def:
        mode search(token:string,option:object,scope*:array,field*:array):trip[]
        mode get(token:string,trip_id:integer,field*:array):trip[]
        mode token(token:string,scope*:array):trip[]

     status code:
     001 : no data
     102 : is draft,only host can access

     x is data in database
     search:
        name in xName 
        startDate*,endDate*
            1. xStart >= startDate,xEnd <= endDate 
            2. if endDate is null then xStart >= startDate
            3. if startDate is null then xEnd <= endDate
        place in xPlace
        tag OR match array

    scope:
    [n,m] LIMIT (n-1)*m , m

    field*

    sort:
    1.rank Desc
    2.startDate Desc
     */

     
    //[check]inputs
    if(!isset($data->token))
        return status(INVAILD_INPUT);
    if(!checkType("so",$data->token))
        return status(INVAILD_INPUT);

    //[login]
    $auth = new FB_auth($data->token);
    $uc = new User();
    $user = $uc->user_exists($auth,['level','user']);
    if(!$user)
        return status(USER_NOT_EXISTS);

    $user_data = $user->fetch_assoc();

    //[check]level
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);
    
    if(isset($data->field)){
        if(!is_array($data->field))
            return status(INVAILD_INPUT);
        if(array_unique(array_map('is_string',$data->field)) !== [true])
            return status(INVAILD_INPUT);
        $field = $data->field;
    }else
            $field = null;

    $trip_data = null;
    
    $mode = 0;
    if(isset($data->option))
        $mode = 1;
    if(isset($data->trip_id))
        $mode = 2;

    $sql_prefix = "(attendable = 0 OR attendable = 1 AND trip_id IN(SELECT trip_id FROM attender user_id IN(SELECT sub_id FROM subscribe WHERE user_id = ?))) AND ";

    switch($mode){
        case 0:
        case 1:
            //SQL definition
            $sql_cond = "";
            $sql_surfix = "";
            $binds = [$user_data['user_id']];
            
            if(isset($data->option)){
                if(!is_object($data->option))
                    return status(INVAILD_INPUT);
                //TODO search options here
                $type_list = ['name'=>'s','startDate'=>'s','endDate'=>'s','place'=>'s','tag'=>'a'];
                $option = new Dataset($type_list,(array)$data->option);
                $option->rebuild($type_list,[]);

                $done = $option->apply($binds,function($key,$value,&$binds){
                    switch($key){
                        case 'name':
                            $binds[] = trim($value);
                            return 'name LIKE %?%';
                        case 'startDate':
                            try{
                                $time = new DatetimeText($value);
                                $time->format("YmdHis");
                                $time = $time->toString();
                                $binds[] = $value;
                                return "startDate >= ?";
                            }catch(InternalException $e){
                                return false;
                            }
                        case 'endDate':
                            try{
                                $time = new DatetimeText($value);
                                $time->format("YmdHis");
                                $time = $time->toString();
                                $binds[] = $value;
                                return 'endDate <= ?';
                            }catch(InternalException $e){
                                return false;
                            }
                        case 'place':
                            $binds[] = $value;
                            return 'place LIKE %?%';
                        case 'tag':
                            $binds = array_merge($binds,$value);
                            $quan = array_fill(0,count($value),'?');
                            return 'tag IN('+join(',',$quan)+')';
                    }
                });
                if(!$done)
                        return status(INVAILD_INPUT);
                    $sql_cond = join(' AND ',$option->toAssoc());
            }else
                $sql_cond = "TRUE";

            if(isset($data->scope)){
                //TODO data scope
                if(!is_array($scope))
                    return status(INVAILD_INPUT);
                if(!checkType("ii",$data->scope[0],$data->scope[1]))
                $sql_surfix = 'LIMIT ?,? ';
                $binds[] = ($data->scope[0]-1)*$data->scope[1];
                $binds[] = $data->scope[1];
            }
            //sort
            $sql_surfix .= "AND isDraft <> 1 ORDER BY rank DESC, startDate DESC";

            $tc = new Trip();
            $trip_data = $tc->retrive($sql_prefix.$sql_cond.' '.$sql_surfix,$binds,$field);
            //no data
            if($trip_data['result']->num_rows == 0)
                return status_code(0,0,1);
            $trip_arr = [];
            while($row = $trip_data['result']->fetch_assoc())
                $trip_arr[] = $row;

            return array_merge(status(SUCCESS),['trip'=>$row]);
        case 2:
            if(!is_integer($data->trip_id))
                return status(INVAILD_INPUT);
            $sql_cond = 'trip_id = ?';
            $tc = new Trip();
            $ac = new Attender();
            $attender_data = $ac->retrieve("trip_id = ? AND user_id = ? AND relationship = 2",[$data->trip_id,$user_data['user_id']],["relationship"]);
            $trip_data = $tc->retrieve($sql_prefix.$sql_cond,[$user_data['user_id'],$data->trip_id],$field);

            $row = $trip_data['result']->fetch_assoc();
            //no data
            if($trip_data['result']->num_rows == 0)
                 return status_code(0,0,1);
            if($row['isDraft'] == 1 && $attender_data['reault']->num_rows == 0)
                return status_code(1,0,2);
            $trip_arr = [];
            while($row = $trip_data['result']->fetch_assoc())
                $trip_arr[] = $row;

            return array_merge(status(SUCCESS),['trip'=>$row]);
    }

    //no data
    // if($trip_data['result']->num_rows == 0)
    //     return status(INVAILD_INPUT);
    // $trip_arr = [];
    // while($row = $trip_data['result']->fetch_assoc())
    //     $trip_arr[] = $row;
    
    // return array_merge(status(SUCCESS),['trip'=>$row]);

});

$trip_con->register("update",function($data){
    /**
     * def:
     * (token:string,trip_id:integer,dataset:object):status 
     * status code:
     * 101:not host or trip not found
     */
    //[check]inputs
    if(!isset($data->token,$data->trip_id,$data->dataset))
        return status(INVAILD_INPUT);
    if(!checkType("sio",$data->token,$data->trip_id,$data->dataset))
        return status(INVAILD_INPUT);

    //[login]
    $auth = new FB_auth($data->token);
    $uc = new User();
    $user = $uc->user_exists($auth,['level','user_id']);
    if(!$user)
        return status(USER_NOT_EXISTS);

    $user_data = $user->fetch_assoc();

    //[check]level
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);

    $tc = new Trip();
    $ac = new Attender();
    if($ac->retrieve("trip_id = ? AND user_id = ? AND relationship IN(1,2)",[$data->trip_id,$user_data['user_id']],['user_id'])->num_rows == 0)
        return status_code(1,0,1);

    $optional_item = ['name'=>'s','place'=>'s','context'=>'s','startDate'=>'s','endDate'=>'s','attendable'=>'b','isDraft'=>'b','plimit'=>'i','tag'=>'a','photo'=>'s','rank'=>'i'];
    try{
        $dataset = new Dataset($optional_item,(array)$data->dataset);
        
        $dataset->rebuild([],array_keys($optional_item));
        $done = $dataset->apply($store,function($key,$value){
            switch($key){
                case 'name':
                case 'place':
                case 'photo':
                    $text = new Text($value);
                    $text->remove_tags([],[]);
                    $text->trim();
                    return $text->toString();
                case 'context':
                    $text = new Text($value);
                    $text->remove_tags(['p','div','h1','span','a','img'],['href','style']);
                    $text->trim();
                    return $text->toString();
                case 'startDate':
                case 'endDate':
                    try{
                        $time = new DatetimeText($value);
                        $time->format("YmdHis");
                        return $time->toString();
                    }catch(InternalException $e){
                        return false;
                    }
                case 'tag':
                    if(array_unique(array_map(function($item){return preg_match("/^[\w\p{Han}]$/");},$value)) !== [true])
                        return false;
                case 'rank':
                    if($user_data['level'] < 2)
                        throw new InsufficientPermissionsException();
                default:
                    return $value;
            }
        });
        if(!$done)
            return status(INVAILD_INPUT);

        $startDate = strtotime($dataset->get('startDate'));
        $endDate = strtotime($dataset->get('endDate'));
        if($startDate <= time() || $startDate > $endDate)
            return status(INVAILD_INPUT);


    }catch(InternalException $e){
        return status(INVAILD_INPUT);
    }

    $uc->update($dataset->toAssoc(),"trip_id = ?",[$data->trip_id]);
    return status(SUCCESS);
});

$trip_con->register("delete",function($data){});

?>