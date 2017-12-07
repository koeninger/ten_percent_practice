<?php

$input = "0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11";

$blocks = preg_split('/\s+/', $input);
foreach($blocks as $id=>$block){
    $blocks[$id] = intval($block);
}

$seen = [];
$steps = 0;
$size = count($blocks);
while(!in_array($blocks, $seen)){
    $seen[] = $blocks;
    $steps++;
    $max = max($blocks);
    $index = array_search($max,$blocks);
    $blocks[$index] = 0;
    for($i = 1;$i <= $max;$i++){
        $current_index = ($index + $i) % $size;
        $blocks[$current_index]++;
    }
}

$index = array_search($blocks,$seen);
echo $steps-$index;