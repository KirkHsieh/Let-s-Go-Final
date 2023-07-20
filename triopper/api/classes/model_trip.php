<?php

class Trip extends Model{
    const table = 'trip';
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
}