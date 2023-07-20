<?php

$filename = [];
function _autoload_dir($folder,$prefix){
    global $filename;
    
    $filename = array_merge($filename,glob("{$folder}/{$prefix}*.php"));
    
}
function loader(){
    $args = func_get_args();
    global $filename;
    $filename = array_merge($filename,$args);
    
}

loader('lib.php','exceptions.php');
_autoload_dir($config->system['classes_dir'],'class_');
_autoload_dir($config->system['classes_dir'],'interface_');
_autoload_dir($config->system['classes_dir'],'model_');
_autoload_dir('router','');


foreach($filename as $file)
    include_once $file;

?>