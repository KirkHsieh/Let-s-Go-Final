<?php
    class Controller{
        private $request = []; //store all method name
        private $request_length = 2; //define how many characters in one request
        public function __construct(int $request_length = null){
            if($request_length != null)
                $this->request_length = $request_length;
        }

        //add a method to controller
        public function register($method,$function){
            if(!is_string($method))
                return false;
            switch(get_class($function)){
                case "Closure":
                case "Controller":break;
                default : return false;
            }
            if(!isset($this->{$method})){
                $temp = &$this->request;
                array_push($temp,$method);
                $this->{$method} = &$function;
                return true;
            }
            return false;
        }

        //execute method or execute method in sub controller define with request
        final public function execute($request,$data = ""){
            if(!is_string($request))
                return false;
            if(strlen($request)<$this->request_length)
                return status(INVAILD_REQUEST);
            //get a request and decode to demical integer
            $index = hexdec(substr($request,0,$this->request_length));

            $req = &$this->request[(int)$index];
            if($req == null){
                return status(INVAILD_REQUEST);
            }
            
            $med = &$this->{$req};
            if($med instanceof Closure){
                try{
                    $in = json_decode($data);
                    if($in == null)
                        throw new InvaildInputException();
                    return $med($in,$this);
                }catch(TokenExpiredException $e){
                    return status(TOKEN_EXPIRED);
                }catch(UserNotExistsException $e){
                    return status(USER_NOT_EXISTS);
                }catch(InsufficientPermissionsException $e){
                    if($GLOBALS['config']->system['debug'])
                        var_dump($e);
                    return status(INSUFFICIENT_PERMISSIONS);
                }catch(InvaildInputException $e){
                    if($GLOBALS['config']->system['debug'])
                        var_dump($e);
                    return status(INVAILD_INPUT);
                }catch(DatabaseConnectionException $e){
                    return status(DB_CONNECTION_ERROR);
                }catch(DatabaseOperationException $e){
                    if($GLOBALS['config']->system['debug'])
                        var_dump($e);
                    return status(DB_OPERATION_ERROR);
                }catch(Exception $e){
                    if($GLOBALS['config']->system['debug'])
                        var_dump($e);
                    return status(KNOWN_ERROR);
                }
            }
            if($med instanceof Controller){
                $request = substr($request,$this->request_length);
                if($request == "")
                    return status(INVAILD_REQUEST);
                return $med->execute($request,$data);
            }
            return false;
            
        }

        public function use_api($method,$obj_data = ""){
            if(isset($this->{$method})){
                $use = $this->{$method};
                return $use(json_encode($obj_data),$this);
            }
            return false;
        }

        public function getRequest(){
            return $this->request;
        }
        
        public function getApiStructure(){
            $structure = [];
            $requests = $this->getRequest();
            foreach($requests as $code => $method){
                
                $apiCode = str_pad(dechex($code),$this->request_length,'0',STR_PAD_LEFT);
                if($this->{$method} instanceof Controller){
                    $apiType = 1;
                    $body = $this->{$method}->getApiStructure();
                    array_push($structure,["name"=>$method,"code"=>$apiCode,"type"=>$apiType,"body"=>$body]);
                }else if($this->{$method} instanceof Closure){
                    $apiType = 0;
                    $name = $method;
                    array_push($structure,["name"=>$name,"code"=>$apiCode,"type"=>$apiType]);
                }else{
                    return false;
                }
                
            }
            return $structure;
        }
    }

?>