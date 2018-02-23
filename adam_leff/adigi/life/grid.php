<?php
include 'cell.php';

class Grid
{
    const SIZE = 10;
    
    private $_grid;
    
    public function __init(){
        mt_srand();
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $this->_grid[$i][$j] = new Cell();
                $this->_grid[$i][$j]->alive = mt_rand(0,1);
            }
        }
        print_r($this->_grid);
    }
    
    public function tick(){
        $newgrid = array();
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $sum = $this->getSum($i,$j);
                if($sum == 3){
                    $this->_grid[$i][$j]->alive = 1;
                } else if($sum != 2){
                    $this->_grid[$i][$j]->alive = 0;
                }
            }
        }
    }
    
    private function getSum($i,$j){
        
    }
}