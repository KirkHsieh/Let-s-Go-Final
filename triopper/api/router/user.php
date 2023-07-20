<?php



//$user_con
$user_con->register("create",function($data){
    /*
        (token)
        status code:
            101:user existed
            102:missing required data (user_id,name,picture)

        TODO:
            define privacy
    */
    if(!isset($data->token))
        return status(INVAILD_INPUT);
    $auth = new FB_auth($data->token);
    $uc = new User();
    $result = $uc->retrieve("user_id = ?",[$auth->get_user()->getId()],['user_id']);
    if($result['result']->num_rows != 0)
        return status_code(1,0,1);
    $user_data = $auth->get_user('/me?fields=id,name,picture{url},location,email&locale=zh_TW');

    //Checking List
    $required_list = ['user_id','name','picture'];
    $optional_list = ['location','email'];

    $dataset = 
    ["user_id" => $user_data->getId(),
    "name" => $user_data->getName(),
    "picture" => $user_data->getPicture(),
    "email" => $user_data->getEmail(),
    "location" => $user_data->getLocation(),
    'date' => date("YmdHis")
    ];
    
    if($dataset['picture'] != null)
        $dataset["picture"] = $dataset["picture"]->getUrl();

    if($dataset['location'] != null)
        $dataset["location"] = $dataset["location"]->getName();

    foreach($required_list as $item){
        if($dataset[$item] == null)
            return status_code(1,0,2);
    }

    foreach($optional_list as $item){
        if($dataset[$item] == null)
            $dataset[$item] = '';
    }
    
    //[execute]
    $uc->create($dataset);
    return status(SUCCESS);
});

$user_con->register("retrieve",function($data){
    //TODO privacy
    /*
        mode1:token : return the user's data
        (token)
        mode2:use user_ids array to get users' data
        (token,user_ids)
        mode3:use a scope to get users' data it admin level needed.
        (token,scope)

        status code:
        001 : no data
    */
        
    if(!isset($data->token))
        return status(INVAILD_INPUT);

    if(isset($data->field)){
        if(!is_array($data->field))
            return status(INVAILD_INPUT);
        if(array_unique(array_map('is_string',$data->field)) !== [true])
            return status(INVAILD_INPUT);
        $field = $data->field;
    }else
        $field = null;


    //[check] token,[get]user_data
    $auth = new FB_auth($data->token);
    $uc = new User();
    $user = $uc->user_exists($auth,['user_id','level']);
    if(!$user)
        return status(USER_NOT_EXISTS);
    $user_data = $user->fetch_assoc();
    $user_id = $user_data['user_id'];
    $user_level = $user_data['level'];

    //[select]mode
    $mode = 1;
    if(isset($data->user_ids))
        $mode = 2;
    else if(isset($data->scope))
        $mode = 3;

    switch($mode){
        case 1:  //token
            //[check] user_level (> 0 needed)
            if($user_level == 0)
                return status(INSUFFICIENT_PERMISSIONS);
            $user_data = $uc->getUser($user_id,$field);
            if($user_data->num_rows == 0)//[if]no data
                return status_code(0,0,1);
            return array_merge(status(SUCCESS),["user"=>[$user_data->fetch_assoc()]]);

        case 2: //ids
            //[check] user_level (> 0 needed)
            if($user_level == 0)
                return status(INSUFFICIENT_PERMISSIONS);

            //[check] $data->user_ids (is array)
            if(!is_array($data->user_ids))
                return status(INVAILD_INPUT);

            //[check] user_id are all string
            if(!for_every(false,"is_string",true,$data->user_ids))
                return status(INVAILD_INPUT);

            if($field && !in_array('privacy',$field))
                $field[] = 'privacy';
                
            $user_data = $uc->retrieve("user_id IN(".join(',',array_fill(0,count($data->user_ids),"?")).")",$data->user_ids,$field);
            if($user_data['result']->num_rows == 0)//[if]no data
                return status_code(0,0,1);

            $user_arr = [];
            while($row = $user_data['result']->fetch_assoc()){
                Utilities::privacy_filter($row);
                $user_arr[] = $row;
            }
            return array_merge(status(SUCCESS),["user"=>$user_arr]);

        case 3: //scope
            /*
                def:scope:[n,m] get n datas for m timese:int
                          [d1,d2] get datas between d1 and d2:string
            */
            //[check] user_level (>= 2 needed)
            if($user_level < 2)
                return status(INSUFFICIENT_PERMISSIONS);
            
            //[check] $data->scope (is array)
            if(!is_array($data->scope))
                return status(INVAILD_INPUT);

            //[check] count of array (== 2 needed)
            if(count($data->scope) != 2)
                return status(INVAIlD_INPUT);

            if($field && !in_array('privacy',$field))
                $field[] = 'privacy';
            if(is_int($data->scope[0]) && is_int($data->scope[1])){
                $user_data = $uc->retrieve("TRUE ORDER BY user_id LIMIT ?,?",[($data->scope[1]-1)*$data->scope[0],$data->scope[0]],$field);
            }else
                return status(INVAILD_INPUT);

                // elseif(is_string($data->scope[0]) && is_string($data->scope[1])){
                //     $user_data = $uc->retrieve("date BETWEEN ? and ? ORDER BY user_id",$data->scope,$field);
                // }
            
            if($user_data['result']->num_rows == 0)//[if]no data
                return status_code(0,0,1);

            $user_arr = [];
            while($row = $user_data['result']->fetch_assoc()){
                Utilities::privacy_filter($row);
                $user_arr[] = $row;
            }
            return array_merge(status(SUCCESS),["user"=>$user_arr]);
            
    }

});

$user_con->register("update",function($data){
    /*
    def:
    mode1:(token,dataset:{"field":"value",...}):000/101(status)
    mode2:(token,dataset,user_id)

    status:
    101:field not exist or type error
    102:target user not exists
    */

    if(!isset($data->token,$data->dataset))
        return status(INVAILD_INPUT);

    if(!is_object($data->dataset))
        return status(INVAILD_INPUT);

    //[check]token,[get]user_id
    $uc = new User();
    $auth = new FB_auth($data->token);
    $user = $uc->user_exists($auth,['user_id','level']);
    if(!$user)
        return status(USER_NOT_EXISTS);
    $user_data = $user->fetch_assoc();
    $user_id = $user_data["user_id"];
    $user_level = $user_data["level"];

    //turn obj to assoc
    $dataset = (array)$data->dataset;

    //no permission to change
    $denied_list = ['user_id','date','picture'];
    foreach($dataset as $item){
        if(in_array($item,$denied_list))
            return status(INSUFFICIENT_PERMISSIONS);
    }



    $mode = (!isset($data->user_id) || $user_id == $data->user_id)?0:1;

    switch($mode){
        case 0:
            if(array_key_exists("level",$dataset))
                return status(INSUFFICIENT_PERMISSIONS);

            //privacy to int
            if(array_key_exists("privacy",$dataset)){
                if(!is_array($dataset['privacy']))
                    return status(INVAILD_INPUT);
                $dataset['privacy'] = Utilities::privacy2Int($dataset['privacy']);
            }

            try{
                $uc->update($dataset,"user_id = ?",[$user_id]);
            }catch(DatabaseOperationException $e){
                return status_code(1,0,1);
            }catch(InteralException $e){
                if($e->getReason() == "TypeError")
                    return status(INVAILD_INPUT);
                return false;
            }
            return status(SUCCESS);
        case 1:
            if($user_level < 2)
                return status(INSUFFICIENT_PERMISSIONS);
            
            //One one can change other's privacy
            if(array_key_exists('privacy',$dataset))
                return status(INSUFFICIENT_PERMISSIONS);
            
            $target = $uc->getUser($data->user_id,['level']);
            if($target->num_rows == 0)
                return status_code(1,0,2);
            $target_data = $target->fetch_assoc();
            if(array_key_exists("level",$dataset)){
                if($target_data['level'] > $user_level || $dataset['level'] > $user_level)
                    return status(INSUFFICIENT_PERMISSIONS);
            }

            try{
                $uc->update($dataset,"user_id = ?",[$data->user_id]);
            }catch(DatabaseOperationException $e){
                return status_code(1,0,1);
            }catch(InteralException $e){
                if($e->getReason() == "TypeError")
                    return status(INVAILD_INPUT);
                return false;
            }
            return status(SUCCESS);
            
    }
    
    

});

$user_con->register("delete",function($data){
    /*
    def:(token,user_id):000 101 112 (level >= 2)
    status:
    101 target user not exists
    */
    if(!isset($data->token,$data->user_id))
        return status(INVAILD_INPUT);
    
    if(!is_string($data->user_id))
        return status(INVAILD_INPUT);
    //[check]token,[get]user_id
    $uc = new User();
    $auth = new FB_auth($data->token);
    $user = $uc->user_exists($auth,['level']);
    if(!$user)
        return status(USER_NOT_EXISTS);
    $user_data = $user->fetch_assoc();
    $user_level = $user_data["level"];

    $target = $uc->getUser($data->user_id,['level']);
    if($target->num_rows == 0)
        return status_code(1,0,1);
    $target_data = $target->fetch_assoc();
    $target_level = $target_data['level'];

    //[check]level >= 2
    if($user_level < 2 || $target_level > $user_level)
        return status(INSUFFICIENT_PERMISSIONS);

    $uc->delete("user_id = ?",[$data->user_id]);
    return status(SUCCESS);
});

$user_con->register("loginCheck",function($data){
    if(!isset($data->token))
        return status(INVAIlD_INPUT);

    //[check]token
    $auth = new FB_auth($data->token);

    //[check]user exists
    $uc = new User();
    if(!$uc->user_exists($auth))
        return status(USER_NOT_EXISTS);
    return status(SUCCESS);

});


$user_con->register("Subscribe",$subscribe_con);
?>