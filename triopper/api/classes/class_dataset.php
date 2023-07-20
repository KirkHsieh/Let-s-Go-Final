<?php

class Dataset{
    private $data = [];
    private $type = [];

    public function __construct(){
        $args = func_get_args();
        $this->setType($args[0]);
        if(count($args) > 1){
            $this->addAssoc($args[1]); //to add
        }
    }

    //add
    public function add(){
        $args = func_get_args();
        $argc = count($args);
        switch($argc){
            case 1:
                if(is_array($args[0]))
                    return $this->addAssoc($args[0]);
                return $this->addDataset($args[0]);
            case 2:
                if(is_string($args[0]))
                    return $this->addKV($arg[0],$arg[1]);
                return false;
        }
        return false;
    }

    private function addAssoc($data){
        if(!is_assoc($data))
            throw new TypeErrorException("data","data[k=>any]");
        foreach($data as $key => $value){
            if(array_key_exists($key,$this->data))
                return false;
            if(array_key_exists($key,$this->type)){
                if(!checkType($this->type[$key],$value))
                    return false;
            }
        }
        $this->data = array_merge($this->data,$data);
        return true;
    }

    private function addDataset($data){
        if(!($data instanceof Dataset))
            return false;
        return $this->addAssoc($data->toAssoc());
    }

    private function addKV($key,$value){
        if(array_key_exists($key,$this->data))
            return false;
        return $this->addAssoc([[$key]=>$value]);
    }
    //end add

    public function apply(&$store,$func){
        foreach($this->data as $key =>$value){
            $result = $func($store,$key,$value);
            if(!$result)
                return false;
            $this->data[$key] = $result;
        }
    }

    public function clone(){
        return new Dataset($this->data);
    }

    public function filter($denied_list){
        if(!is_array($denied_list))
            throw new TypeErrorException("denied_list","array");
        foreach($denied_list as $key){
            $this->remove($key);
        }
    }

    public function get($key){
        if(!in_array($key,$this->data))
            throw new InteralException("No Data");
        return $this->data[$key];
    }

    public function hasKey($key){
        if(!is_string($key))
            throw new TypeErrorException("text","string");
        return array_key_exists($key,$this->data);
    }

    public function length(){
        return count($this->data);
    }

    public function modify($key,$value){
        if(array_key_exists($key,$this->data)){
            $this->data[$key] = $value;
            return true;
        }
        return false;
    }
    
    public function rebuild($required_list,$optional_list){
        foreach($this->data as $key=>$v){
            if(!in_array($key,$required_list))
                return false;
            elseif(!in_array($key,$optional_list))
                unset($this->data[$key]);
        }
    }

    public function remove($key){
        if(array_key_exists($key,$this->data))
            unset($this->data[$key]);
    }

    protected function setType($types){
        if(!is_assoc($types) || array_unique(array_map(function($v){
            $ref = ['s','i','b','d','a','o','r','n'];
            return in_array($v,$ref);
        },$arg[0])) !== [true])
            throw new TypeErrorException("data","assoc[k=>int]");
        
        $this->type = $types;
    }

    public function toAssoc(){
        return $this->data;
    }
    
    /**
     * __construct(types:assoc) =>an empty dataset
     * __construct(type:assoc,data:assoc) =>a dataset include some data
     * 
     * rebuild(required:list,optional:list) :bool
     * -setType(types:assoc):void
     * filter(denied:list) :void
     * add(key:string,value:any) :bool
     * add(data:Dataset) :bool
     * add(data:assoc_array) :bool
     * modify(key:string,value:any):bool
     * get(key:string) :any
     * remove(key:string) :void
     * toAssoc() :assoc_array
     * clone() :Dataset
     * length() :integer
     */
}