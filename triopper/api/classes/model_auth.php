<?php

class permission extends model{
    public $permission_table;
    public function create(){}
    public function retrieve(){}
    public function update(){}
    public function delete(){}
}

class FB_auth implements authenticator{
    private $fb;
    private $token;
    private $user;

    public function __construct($accessToken){
        global $config,$fb;
        $this->verify($accessToken);
    }

    public function verify($data){ //data is AccessToken
        global $fb;
        try{
            $response = $fb->get('/me?fields=id',$data);
        }catch(Exception $e){
            throw new TokenExpiredException();
        }
        $this->token = $data;
        $this->user = $response->getGraphUser();
        
    }

    public function get_user($graph = null){
        global $fb;
        if($graph != null){
            try{
                $response = $fb->get($graph,$this->token);
            }catch(Exception $e){
                throw new TokenExpiredException();
            }
            $this->user = $response->getGraphUser();
        }
        return $this->user;
    }
    
}

?>