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
                $this->_grid[$i][$j]->value = mt_rand(0,1) ? mt_rand(-30,31) : 0;
            }
        }
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
                $line .= $this->_grid[$i][$j]->value . " ";
            }
            echo $line . "\n";
        }
        echo "\n\n";
    }
    
    public function getMemoryAt($addr){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        echo "coords " . $x . 'x' . $y . ": " . $this->_grid[$x][$y]->value . "\n";
        return $this->_grid[$x][$y]->value;
    }
    
    public function setMemoryAt($addr, $val){
        $x = intval($addr/self::SIZE);
        $y = $addr % self::SIZE;
        $this->_grid[$x][$y]->value = $val;
    }
    
    public function subleq(){
        $a_addr = $this->getMemoryAt($this->_pc);
        if($a_addr < 0){
            $a_addr = $this->getMemoryAt($a_addr * -1);
        }
        $b_addr = $this->getMemoryAt($this->_pc + 1);
        if($b_addr < 0){
            $b_addr = $this->getMemoryAt($b_addr * -1);
        }
        $a_val = $this->getMemoryAt($a_addr);
        $b_val = $this->getMemoryAt($b_addr);
        $c_val = $this->getMemoryAt($this->_pc + 2);
        if($c_val < 0){
            $c_val = $this->getMemoryAt($c_val * -1);
        }
        
        echo "Instruction: " . $a_val . " " . $b_val . " "  . $c_val . "\n";
        
        $b_val = $b_val - $a_val;
        $this->setMemoryAt($b_addr,$b_val);
        
        
        
        if($b_val <= 0){
            $this->_pc = $c_val;
        } else {
            $this->_pc += 3;
        }
    }
}