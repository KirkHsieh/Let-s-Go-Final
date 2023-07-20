<?php

$subscribe_con->register("create",function($data){
    /*
    def:
    (token,user_id) : user_id will be subscribed;permission > 0

    status code:
    101: target user not exists
    102: target equals to user
    103: user has subscribed target
    */
    if(!isset($data->token,$data->user_id))
        return status(INVAILD_INPUT);
    if(!checkType("ss",$data->token,$data->user_id))
        return status(INVAILD_INPUT);
    
    //[check] token vaild , and users are exists
    $uc = new User();
    $auth = new FB_auth($data->token);
    $user = $uc->user_exists($auth,['user_id','level']);
    if(!$user)
        status(USER_NOT_EXISTS);

    //target user
    $sub_user = $uc->getUser($data->user_id,['user_id']);
    if($sub_user->num_rows == 0)
        return status_code(1,0,1);

    //get user data
    $user_data = $user->fetch_assoc();

    //level > 0
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);

    
    $user_id = $user_data['user_id'];
    $sub_id = $data->user_id;
    $date = date("YmdHis");

    //create a subscribe from $user_id to $sub_id
    $sc = new Subscribe();

    //target equals to user
    if($user_id == $sub_id)
        return status_code(1,0,2);

    //user has subscribed target
    if($sc->isSubscribed($user_id,$sub_id))
        return status_code(1,0,3);
    
    $sc->create($user_id,$sub_id,$date);
    return status(SUCCESS);
});

$subscribe_con->register("retrieve",function($data){
    /*
    (token,state=0,field) =>take subs
    (token,state=1,field) =>take fans

    permission > 0

    status code:
    001 : no data
    */

    if(!isset($data->token,$data->state))
        return status(INVAILD_INPUT);

    if(!checkType("si",$data->token,$data->state))
        return status(INVAILD_INPUT);

    //[check] token vaild
    $uc = new User();
    $auth = new FB_auth($data->token);
    $user = $uc->user_exists($auth,['user_id','level']);
    if(!$user)
        status(USER_NOT_EXISTS);
    
    //get user data
    $user_data = $user->fetch_assoc();

    //level > 0
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);


    $sc = new Subscribe();
    $field = null;
    switch($data->state){
        case 0:
            $field = 'sub_id';
            $result = $sc->retrieve("user_id = ?",[$user_data['user_id']],[$field]);
            break;
        case 1:
            $field = 'user_id';
            $result = $sc->retrieve("sub_id = ?",[$user_data['user_id']],[$field]);
            break;
        default:
            return status(INVAILD_INPUT);
    }

    if($result['result']->num_rows == 0)
        return status_code(0,0,1);
    
    $ids = [];
    while($row = $result['result']->fetch_assoc()){
        $ids[] = $row[$field];
    }

    return array_merge(status(SUCCESS),['user_ids'=>$ids]);
});

$subscribe_con->register("update",function(){
    return status(INVAILD_REQUEST);
});

$subscribe_con->register("delete",function($data){
    /*
    def:
    (token,user_id) => remove relation between user and subscriber

    permission > 0
    status code:
    101:target user exists
    */
    if(!isset($data->token,$data->user_id))
        return state(INVAILD_INPUT);

    if(!checkType("ss",$data->token,$data->user_id))
        return state(INVAILD_INPUT);

    //[check] token vaild
    $uc = new User();
    $auth = new FB_auth($data->token);
    $user = $uc->user_exists($auth,['user_id','level']);
    if(!$user)
        status(USER_NOT_EXISTS);

    //target user
    $sub_user = $uc->getUser($data->user_id,['user_id']);
    if($sub_user->num_rows == 0)
        return status_code(1,0,1);
    
    //get user data
    $user_data = $user->fetch_assoc();

    //level > 0
    if($user_data['level'] == 0)
        return status(INSUFFICIENT_PERMISSIONS);

    $sc = new Subscribe();
    $sc->delete("user_id = ? AND sub_id = ?",[$user_data['user_id'],$data->user_id]);
    return status(SUCCESS);
});