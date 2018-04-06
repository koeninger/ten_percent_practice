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
    
    public function displayString(){
        $str = $this->value . '';
        $addition = '';
        if($this->value > 9){
            $addition = ' ';
        } else if($this->value >= 0){
            $addition = '  ';
        } else if($this->value >= -9){
            $addition = ' ';
        }
        
        return $addition . $str;
    }
}