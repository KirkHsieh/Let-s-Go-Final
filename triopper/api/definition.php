<?php

//system
$config->system['classes_dir'] = 'classes';
$config->system['debug'] = false;


//mysql connection
$config->mysql['host'] = null;
$config->mysql['username'] = null;
$config->mysql['password'] = null;
$config->mysql['port'] = null;
$config->mysql['database'] = null;


const SUCCESS = "000";
const USER_NOT_EXISTS = "110";
const TOKEN_EXPIRED = "111";
const INSUFFICIENT_PERMISSIONS = "112";
const INVAILD_REQUEST = "120";
const DB_CONNECTION_ERROR = "130";
const DB_OPERATION_ERROR = "131";
const INVAILD_INPUT = "140";
const KNOWN_ERROR = "150";
?>