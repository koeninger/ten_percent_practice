<?php
include 'cell.php';

class Grid
{
    const SIZE = 6;
    const MUTATION_RATE = 999999;
    
    private $_grid;
    private $_pc = 0;
    
    public function __init(){
        $this->_grid = [];
        mt_srand();
        for($i = 0; $i < self::SIZE; $i++){
            for($j = 0; $j < self::SIZE; $j++){
                $this->_grid[$i][$j] = new Cell();
                $this->_grid[$i][$j]->value = mt_rand(-30,31);
            }
        }
        $this->display();
        return $this->_grid;
    }
    
    public function tick(){
        $this->subleq();
        $this->display();
    }
    
    public function display(){
        for($i = 0; $i < self::SIZE; $i++){
            $line = '';
            for($j = 0; $j < self::SIZE; $j++){
                $line .= $this->_grid[$i][$j]->displayString() . " ";
            }
            echo $line . "\n";
        }
        echo "\n\n";
    }
    
    public function getMemoryAt($addr){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        return $this->_grid[$x][$y]->value;
    }
    
    public function setMemoryAt($addr, $val){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        $this->_grid[$x][$y]->setValue($val);
        if(rand(0,self::MUTATION_RATE) == 0){
            $this->_grid[$x][$y]->mutate();
        }
    }
    
    public function subleq(){
        $i = 0;
        $a_addr = $this->getMemoryAt($this->_pc);
        while($a_addr < 0 && $i < (self::SIZE * self::SIZE)){
            $a_addr = $this->getMemoryAt($a_addr * -1);
        }
        if($i == self::SIZE * self::SIZE){
            $this->_pc++;
            return;
        }
        $i = 0;
        $b_addr = $this->getMemoryAt($this->_pc + 1);
        while($b_addr < 0 && $i < (self::SIZE * self::SIZE)){
            $b_addr = $this->getMemoryAt($b_addr * -1);
        }
        if($i == self::SIZE * self::SIZE){
            $this->_pc++;
            return;
        }
        $a_val = $this->getMemoryAt($a_addr);
        $b_val = $this->getMemoryAt($b_addr);
        
        $i = 0;
        $c_val = $this->getMemoryAt($this->_pc + 2);
        while($c_val < 0 && $i < (self::SIZE * self::SIZE)){
            $c_val = $this->getMemoryAt($c_val * -1);
        }
        if($i == self::SIZE * self::SIZE){
            $this->_pc++;
            return;
        }
        
        $b_val = $b_val - $a_val;
        $this->setMemoryAt($b_addr,$b_val);
        
        
        
        if($b_val <= 0){
            $this->_pc = $c_val;
        } else {
            $this->_pc += 3;
        }
    }
}