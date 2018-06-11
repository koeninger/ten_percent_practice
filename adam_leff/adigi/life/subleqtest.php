<?php 
$memory = [3,4,6,7,7,7,3,4,0];
$_pc = 0;

function getMemoryAt($pc){
    global $memory, $_pc;
    return $memory[$pc];
}

function setMemoryAt($addr,$val){
    global $memory, $_pc;
    $memory[$addr] = $val;
}

function subleq(){
    global $memory, $_pc;
    $a_addr = getMemoryAt($_pc);

    $b_addr = getMemoryAt($_pc + 1);

    $a_val = getMemoryAt($a_addr);
    $b_val = getMemoryAt($b_addr);
    
    $c_val = getMemoryAt($_pc + 2);
    
    $b_val = $b_val - $a_val;
    setMemoryAt($b_addr,$b_val);
    
    
    
    if($b_val <= 0){
        $_pc = $c_val;
    } else {
        $_pc += 3;
    }
    
    print_r($memory);
    echo $_pc;
}

subleq();
subleq();
subleq();
