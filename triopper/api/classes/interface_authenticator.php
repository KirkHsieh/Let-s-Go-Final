<?php

interface authenticator {
    // private $user_data;
    // private $is_pass = false;

    function verify($data);
}

?>