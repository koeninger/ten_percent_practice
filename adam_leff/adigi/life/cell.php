<?php

class Cell
{
    const MAX = 31;
    const MIN = -30;
    public $value = 0;
    
    public function setValue($val){
        if($val < self::MIN){
            $val = $val % self::MIN;
        }
        if($val > self::MAX){
            $val = $val % self::MAX;
        }
        
        $this->value = $val;
    } 
}