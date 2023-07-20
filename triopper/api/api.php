<?php
include_once 'definition.php';
include_once 'config.php';
include_once 'autoload.php';
require_once "Facebook/autoload.php";

if(!$config->system['debug'])
    error_reporting(0);
header("Content-type: application/json; charset=utf-8");

$fb = new Facebook\Facebook([
   'app_id' => $config->fb["app_id"],
   'app_secret' => $config->fb["app_secret"],
   'default_graph_version' => 'v2.11',
   ]);

if(!isset($_POST['api']))
   die(json_encode(status(INVAILD_REQUEST)));

$data = (isset($_POST['data']))?$_POST['data']:null;
if($result = $controller->execute($_POST['api'],$data))
    die(json_encode($result,JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

die(json_encode(status(KNOWN_ERROR)));
?>