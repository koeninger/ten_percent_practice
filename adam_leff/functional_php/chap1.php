<?php 

class ClosureInsideClass{
    public function testing(){
        return function(){
            return $this;
        };
    }
}

$object = new ClosureInsideClass();
$test = $object->testing();
var_dump($test());
var_dump($test()->testing());