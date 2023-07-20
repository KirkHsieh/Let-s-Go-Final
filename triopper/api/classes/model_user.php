<?php

//To operate table user
class User extends model{
    const table = "user";

    public function create($dataset){
        return parent::_insert(self::table,$dataset);
    }

    public function retrieve($cond,$bind,$fields = null){
        return parent::_select(self::table,$fields,$cond,$bind);
    }

    public function update($dataset,$cond,$bind){
        return parent::_update(self::table,$dataset,$cond,$bind);
    }

    public function delete($cond,$bind){
        return parent::_delete(self::table,$cond,$bind);
    }

    public function user_exists($auth,$fields = null){
        if($fields == null)
            $fields = ['user_id'];
        if(!($auth instanceof FB_auth))
            throw new TypeErrorException('auth',"FB_Auth");
        $result = $this->retrieve("user_id = ?",[$auth->get_user()->getId()],$fields);
        if($result['result']->num_rows == 0)
            return false;
        return $result['result'];
    }

    public function getUser($id,$fields){
        $result = $this->retrieve("user_id = ?",[$id],$fields);
        return $result['result'];
    }

}


?>