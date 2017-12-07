<?php

$size = 20;
$input = 361527;

$value = 1;
$cell = 1;
$loop = 1;

$arr = array();
for($i = 0;$i < $size;$i++){
    for($j = 0;$j < $size;$j++){
        $arr[$i][$j] = 0;
    }
}

$x = $size/2;
$y = $size/2;

$arr[$x][$y] = 1;

while($value < $input){
    $pos = nextlocation($x,$y,$loop,$size);
    $cell++;
    $s = sqrt($cell);
    $s_int = intval($s);
    if($s_int * $s_int == $cell && $s%2 == 1){
        $loop++;
    }
    //print_r($pos);
    $x = $pos[0];
    $y = $pos[1];
    $value = sum($x,$y,$arr,$size);
    $arr[$x][$y] = $value;
}

//print_r($arr);

echo $value;

function sum($x,$y,$arr,$size){
    $val = 0;

    $left = $x > 0;
    $right = $x < $size-1;
    $up = $y > 0;
    $down = $y < $size-1;

    if($left){
        $val += $arr[$x-1][$y];
        $val += $up ? $arr[$x-1][$y-1] : 0;
        $val += $down ? $arr[$x-1][$y+1] : 0;
    }

    if($right){
        $val += $arr[$x+1][$y];
        $val += $up ? $arr[$x+1][$y-1] : 0;
        $val += $down ? $arr[$x+1][$y+1] : 0;
    }

    if($up){
        $val += $arr[$x][$y-1];
    }

    if($down){
        $val += $arr[$x][$y+1];
    }

    return $val;
}

function nextlocation($x,$y,$loop,$size){
    $realx = $x-($size/2);
    $realy = $y-($size/2);
    print_r([$realx,$realy,$loop]);
    if($realx == $realy){
        return $realx < 0 ? [$x,$y+1] : [$x+1,$y];
    }

    if($realx == $realy * -1){
        return $realx < 0 ? [$x+1,$y] : [$x-1,$y];
    }

    if($realx < 0 && abs($realx) == $loop){
        if($realy < $loop){
            return [$x,$y+1];
        }
        return [$x+1,$y];
    }

    if($realx < 0 && $realy < 0 && abs($realx) < $loop-1){
        return [$x-1,$y];
    }

    if($realx > 0 && $realx == $loop){
        if($realy > $loop * -1){
            return [$x,$y-1];
        }
        return [$x-1,$y];
    }

    if($realx > 0 && $realy> 0 && $realx < $loop-1){
        return [$x+1,$y];
    }

    if($realy == $loop){
        return [$x+1,$y];
    }

    return [$x-1,$y];
}
