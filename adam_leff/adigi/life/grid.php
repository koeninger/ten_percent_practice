<?php
include 'cell.php';

class Grid
{
    const SIZE = 6;
    
    private $_grid;
    private $_pc = 0;
    
    public function __init(){
        $this->_grid = [];
        mt_srand();
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $this->_grid[$i][$j] = new Cell();
                $this->_grid[$i][$j]->alive = mt_rand(0,1) ? mt_rand(0,7) : 0;
            }
        }
        return $this->_grid;
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
    
    public function getMemoryAt($addr){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        return $this->_grid[$x][$y];
    }
    
    public function setMemoryAt($addr, $val){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        $this->_grid[$x][$y] = $val;
    }
    
    public function subleq(){
        $a_addr = $this->getMemoryAt($this->_pc);
        $b_addr = $this->getMemoryAt($this->_pc + 1);
        while($a_addr < 0){
            $a_addr = $this->getMemoryAt($a_addr * -1);
        }
        while($b_addr < 0){
            $b_addr = $this->getMemoryAt($b_addr * -1);
        }
        $a_val = $this->getMemoryAt($a_addr);
        $b_val = $this->getMemoryAt($b_addr);
        
        $b_val = $b_val - $a_val;
        $this->setMemoryAt($b_addr,$b_val);
        
        $c_val = $this->getMemoryAt($this->_pc + 2);
        if($c_val < 0){
            $this->getMemoryAt($c_val * -1);
        }
        if($b_val <= 0){
            $this->_pc = $c_val;
        } else {
            $this->_pc += 3;
        }
    }
}