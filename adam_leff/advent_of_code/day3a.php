<?php

$input = 361527;

$square = 1;
$distance = 0;
for($i = 1; pow($i,2) < $input; $i+=2){
    $square = pow($i,2);
    $distance = $i;
}
$distance_to_center = floor($i/2);

$move = $input - $square;

while($move > $distance){
    $square += $distance;
    $move -= $distance;
}

$lr = abs($move - $distance_to_center);

echo $lr + $distance_to_center;
