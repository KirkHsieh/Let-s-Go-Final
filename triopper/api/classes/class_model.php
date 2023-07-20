<?php

class model{
    private $database;
    protected $db_connected = false;

    public function __construct(){
        global $config;
        $set = &$config->mysql;
        $database = new mysqli($set['host'],$set['username'],$set['password'],$set['database'],$set['port']);
        if($database instanceof mysqli){
            if(!$database->connect_errno){
                $this->db_connected = true;
                $this->database = $database;
            }
        }


        if(!$this->db_connected)
            throw new DatabaseConnectionException();

        $this->database->set_charset("utf8");

    }

    public function __destruct(){
        if($this->database instanceof mysqli)
            $this->database->close();
    }
    //overloading
    public function __call($name ,$args){

        switch($name){
            case 'execSQL':
                if(count($args) == 1)
                    return call_user_func_array([$this,'execSQL_s'],$args);
                
                if(count($args) > 1)
                    return call_user_func_array([$this,'execSQL_bind'],$args);
                
        }
    }

    //executing sql
    final protected function execSQL_s($sql){
        /*
            bool:(sql:string)
        */
        //[init]

        //check connection
        

        $db = &$this->database;
        $stmt = $sb->prepare($sql);

        if(!$stmt)
            throw new DatabaseOperationException();

        //[execute]
        $bool = $stmt->execute();

        //free memory
        $stmt->close();
        return $bool;
    }

    final protected function execSQL_bind(){
        /*
            data_arr|null : (sql:string ,...args)
        */
        //[init]
        $db = &$this->database;

        $args = func_get_args();

        $sql = (is_string($args[0]))?$args[0]:false;
        if(!$sql)
            throw new InteralException(null);
        
        $stmt = $db->prepare($sql);
        if(!$stmt)
            throw new DatabaseOperationException();

        $sql_type = '';
        for($i = 1;$i < count($args);$i++){
            switch(gettype($args[$i])){
                case "integer":$sql_type .="i";break;
                case "double":$sql_type .= "d";break;
                case "string":$sql_type .= "s";break;
                default:throw new InteralException("TypeError");
            }
        }

        $bind_param = array_merge([$sql_type],array_values(array_slice($args,1)));
        
        if(!call_user_func_array([$stmt,'bind_param'],refValues($bind_param)))
            throw new DatabaseOperationException();
        
        //[execute]
        if(!$stmt->execute())
            throw new DatabaseOperationException();

        $reData = ['result'=>$stmt->get_result(),'insert_id'=>$stmt->insert_id,'affected_rows'=>$stmt->affected_rows];
        $stmt->close();
        
        return $reData;
    } 

    final protected function field_exists($table, $fields){
        if(!is_string($table))
            throw new TypeErrorException('table','string');
        if(!for_every(false,'is_string',true,$fields))
            throw new TypeErrorException('fields','string array');

        $result = $this->execSQL("SHOW COLUMNS FROM ?",$table);
        if($result->num_rows == 0)
            return false;
        foreach($fields as $item){
            $exist = false;
            while($row = $result->assoc()){
                if($row['Field'] == $item)
                    $exist = true;
            }
            if(!$exist)
                return false;
        }
        return true;

    }
    //insert data into table 
    final protected function _insert($table, $dataset){
        if(!is_string($table))
            throw new TypeErrorException('table','string');
        $s = array_fill(0,count($dataset),'?');
        
        $sql = sprintf("INSERT INTO %s (%s) VALUES(%s)",$table,join(array_keys($dataset),','),join($s,','));
        return call_user_func_array([$this,'execSQL'],array_merge([$sql],array_values($dataset)));

    }
    //select rows from table
    final protected function _select($table,$fields = null,$cond = null,$bind = null){
        if(!is_string($table))
            throw new TypeErrorException('table','string');

        $sql_field = '*';
        if($fields != null){
            if(is_array($fields))
                $sql_field = join($fields,',');
            elseif(is_string($fields))
                $sql_field = $fields;
            else
                throw new TypeErrorException('fields','array|string');
        }

        $sql_cond = '';
        if($cond != null){
            if(!is_string($cond))
                throw new TypeErrorException('condition','string');
            if($bind != null){
                if(!is_array($bind))
                    throw new TypeErrorException('bind','array');
            }else
                $bind = [];
                
            
            $sql_cond = $cond;
        }

        $sql = sprintf("SELECT %s FROM %s WHERE %s",$sql_field,$table,$sql_cond);
        return call_user_func_array([$this,'execSQL'],array_merge([$sql],$bind));
    }
    //update row from table where [condition]
    final protected function _update($table,$dataset,$cond = null,$bind = null){
        if(!is_string($table))
            throw new TypeErrorException('table','string');
        if(!is_array($dataset))
            throw new TypeErrorException('dataset','array');

        

        $sql_cond = '';
        $bindcount = 0;
        if($cond != null){
            if(!is_string($cond))
                throw new TypeErrorException('condition','string');
            if($bind != null){
                if(!is_array($bind))
                    throw new TypeErrorException('bind','array');
            }else
                $bind = [];
                
            $sql_cond = $cond;
        }


        $sql_sets = [];
        foreach(array_keys($dataset) as $key){
            array_push($sql_sets,$key."= ?");
        }

        $sql = sprintf("UPDATE %s SET %s WHERE %s",$table,join(",",$sql_sets),$sql_cond);
        return call_user_func_array([$this,'execSQL'],array_merge([$sql],array_merge(array_values($dataset),$bind)));
    }
    //delete row from table where [condition]
    final protected function _delete($table,$cond,$bind = null){
        if(!is_string($table))
            throw new TypeErrorException('table','string');
        if(!is_string($cond))
            throw new TypeErrorException('condition','string');
        
        if($bind != null){
            if(!is_array($bind))
                throw new TypeErrorException('bind','array');
        }else
            $bind = [];

        $sql = sprintf("DELETE FROM %s WHERE %s",$table,$cond);
        return call_user_func_array([$this,'execSQL'],array_merge([$sql],$bind));
    }

    // abstract public function create();

    // abstract public function retrieve();
    
    // abstract public function update();

    // abstract public function delete();

    
}

?>