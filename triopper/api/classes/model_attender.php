<?php

class Attender extends Model{
    const table = 'attender';
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

    public function getAttenders($trip_id,$field){
        /*
        def:
        (trip_id:integer):mysqli_result
        */
        $result = $this->retrieve("trip_id = ?",[$trip_id],$field);
        return $result['result'];
    }
}