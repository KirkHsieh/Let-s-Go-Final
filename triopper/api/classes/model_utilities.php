<?php
class Utilities extends Model{
    public static function privacy_filter(&$user){
        /*
            for checking one user and set all private data to null 
        */
        if(!isset($user['privacy']))
            throw new InteralException(null);

        $list = ['location','email','personality','hobby','introduction'];

        for($i=0; $i < count($list);$i++){
            if(array_key_exists($list[$i],$user) && ($user['privacy'] & pow(2,$i)) == 0)
                $user[$list[$i]] = null;
        }

        //remove privacy from user
        unset($user['privacy']);
    }

    public static function privacy2Int($data){
        $list = ['location','email','personality','hobby','introduction'];
        $n = 0;
        for($i = 0;$i < count($list);$i++){
            if(in_array($list[$i],$data))
                $n |= pow(2,$i);
        }
        return $n;
    }
}

?>