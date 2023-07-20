<?php

//To operate subscribe
class Subscribe extends Model{
    const table = "subscribe";

    public function create($user_id,$sub_id,$date){
        $dataset = ['user_id'=>$user_id,'sub_id'=>$sub_id,'date'=>$date];
        return parent::_insert(self::table,$dataset);
    }

    public function retrieve($cond,$bind,$field){
        return parent::_select(self::table,$field,$cond,$bind);
    }

    public function delete($cond,$bind){
        return parent::_delete(self::table,$cond,$bind);
    }

    public function isSubscribed($user_id,$sub_id){
        $data = $this->retrieve("user_id = ? AND sub_id = ?",[$user_id,$sub_id],['user_id']);
        return $data['result']->num_rows != 0;
    }

}