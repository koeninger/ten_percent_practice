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
                $this->_grid[$i][$j]->alive = mt_rand(0,1) ? mt_rand(0,16) : 0;
            }
        }
        $this->display();
    }
    
    public function tick(){
        $newgrid = array();
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $newgrid[$i][$j] = new Cell();
                $newgrid[$i][$j]->alive = 0;
            }
        }
        
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $sum = $this->getSum($i,$j);
                if($sum == 3){
                    $newgrid[$i][$j]->alive = 1;
                } else if($sum != 2){
                    $newgrid[$i][$j]->alive = 0;
                }
            }
        }
        $this->_grid = $newgrid;
        $this->display();
    }
    
    public function display(){
        for($i = 0; $i < self::SIZE; $i++){
            $line = '';
            for($j = 0; $j < self::SIZE; $j++){
                $line .= $this->_grid[$i][$j]->alive ? '1' : '0';
            }
            echo $line . "\n";
        }
        echo "\n\n";
    }
    
    private function getSum($i,$j){
        $coordinates = [
            [$i-1,$j-1],
            [$i-1,$j],
            [$i-1,$j+1],
            [$i,$j-1],
            [$i,$j+1],
            [$i+1,$j-1],
            [$i+1,$j],
            [$i+1,$j+1]
        ];
        
        $sum = 0;
        foreach($coordinates as $id => $c){
            if($c[0] >= 0 && $c[0] < self::SIZE && $c[1] >= 0 && $c[1] < self::SIZE){
                $sum+= $this->_grid[$c[0]][$c[1]]->alive > 0 ? 1 : 0;
            }
        }
        
        return $sum;
    }
}