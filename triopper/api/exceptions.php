<?php

class DenyByAccessException extends Exception{

}

class TokenExpiredException extends DenyByAccessException{

}

class UserNotExistsException extends DenyByAccessException{

}

class InsufficientPermissionsException extends DenyByAccessException{

}

class InvaildInputException extends Exception{

}

//database
class DatabaseException extends Exception{

}

class DatabaseConnectionException extends DatabaseException{

}

class DatabaseOperationException extends DatabaseException{

}

class InteralException extends Exception{
    private $reason;
    public function __construct($reason){
        if($reason != null)
            $this->reason = $reason;
    }
    public function getReason(){return $this->reason;}
}

class TypeErrorException extends InteralException{
    private $param;
    private $correct;

    public function __construct($param,$correct){
        parent::__construct("Missing or Wrong Datatype");

        $this->param = $param;
        $this->correct = $correct;
    }

    
    // public function getMessage(){
    //     return sprintf("TypeError: %s is not %s.",$this->param,$this->correct);
    // }
}

class DataFormatWrongException extends InteralException{
    
}

?>