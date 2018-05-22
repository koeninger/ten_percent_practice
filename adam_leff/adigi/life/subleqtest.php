<?php 
function subleq(){
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
