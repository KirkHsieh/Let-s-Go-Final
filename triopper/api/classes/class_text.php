<?php
class Text{
    /**
     * __construct(text:string):void
     * __construct():void
     * trim():void
     * append(text:string):void
     * insertBefore(text:string):void
     * length():int
     * remove_tags(keepTag,keepAttr):void
     * toString():string
     */

    private $text;
    public function __construct(){
        $args = func_get_args();
        if(count($args) == 1){
            $this->text = $args[0];
        }
    }

    public function append($text){
        if(!is_string($text))
            throw new TypeErrorException("text","string");
        $this->text .= $text;
    }

    public function insertBefore($text){
        if(!is_string($text))
            throw new TypeErrorException("text","string");
        $this->text = $text.$this->text;
    }

    public function setText($text){
        if(!is_string($text))
            throw new TypeErrorException("text","string");
        $this->text = $text;
    }

    public function length(){
        return strlen($this->text);
    }

    public function remove_tags($allowed_tags = [],$allowed_attrs = []){
        $this->text = strip_htmltags($this->text,$allowed_tags,$allowed_attrs);
    }

    public function toString(){
        return $this->text;
    }

    public function trim(){
        $this->data = trim($this->data);
    }

}

class DatetimeText extends Text{
    public function format($format){
        if(!is_string($text))
            throw new TypeErrorException("text","string");
        $timestamp = strtotime($this->toString());
        if(!$timestamp)
            throw new DataFormatWrongException("time format");
        $this->setText(date($format,$timestamp));
    }
}