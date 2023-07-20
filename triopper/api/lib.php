<?php
    function for_every($callarr,$func,$value,$args){
        if(!is_array($args))
            throw new TypeErrorException('args','array');
        if(!(is_string($func) || is_array($func)))
            throw new TypeErrorException('func','string|array');

        foreach($args as $arg){
            if($callarr)
                $res = call_user_func_array($func,$arg);
            else
                $res = call_user_func($func,$arg);
            if($value != $res)
                return false;
        }
        return true;
    }

    function array_values_equal($arr1,$arr2){
        if(count($arr1) != count($arr2))
            return false;
        
        foreach($arr1 as $value){
            if(!in_array($value,$arr2))
                return false;
        }

        return true;
    }

    function status_code($code_status,$code_reason,$code_msg){
        return ['status'=>"{$code_status}{$code_reason}{$code_msg}"];
    }

    function status($s){
        return ['status'=>$s];
    }

    function refValues($arr){
        if (strnatcmp(phpversion(),'5.3') >= 0) //Reference is required for PHP 5.3+
        {
            $refs = array();
            foreach($arr as $key => $value)
                $refs[$key] = &$arr[$key];
            return $refs;
        }
        return $arr;
    }

    function checkType(){
        $args = func_get_args();
        $type = $args[0];
        $ref = ['s'=>'string','i'=>'integer','b'=>'boolean','d'=>'double','a'=>'array','o'=>'object','r'=>'resource','n'=>'NULL'];
        unset($args[0]);
        foreach($args as $i => $item){
            if(gettype($item) != $ref[$type{$i-1}])
                return false;
        }
        return true;
    }
    function is_assoc($array){
        return is_array($array) && array_unique(array_map('is_string',$array)) === [true];
    }
    
    function strip_htmltags($html,$allowed_tags = [],$allowed_attrs = []){
        if(!strlen($html))
            return false;
        
        $dom = new DOMDocument();
        $encode = '<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></head>';
        $html = "{$encode}<body>".$html."</body></html>";
        array_push($allowed_tags,"body");
        array_push($allowed_tags,"html");
        $allowed_tags = array_unique($allowed_tags);
        if ($dom->loadHTML($html,LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD)){
            if(libxml_get_last_error()){
                libxml_clear_errors();
                
                return false;
            }
            foreach ($dom->getElementsByTagName("*") as $tag){
              if (!$allowed_tags || !in_array($tag->tagName, $allowed_tags)){
                $tag->parentNode->removeChild($tag);
              }else{
                foreach ($tag->attributes as $attr){
                  if (!$allowed_attrs || !in_array($attr->nodeName, $allowed_attrs)){
                    $tag->removeAttribute($attr->nodeName);
                  }
                }
              }
            }
            
          }else
          return false;
        $result = $dom->saveHTML();
        return  preg_replace_callback("/&#[^;]*;/",function($str){return html_entity_decode($str[0]);},str_replace(["<body>","</body>","<html>","</html>",$encode,"\n"],"",$result));
    }
?>