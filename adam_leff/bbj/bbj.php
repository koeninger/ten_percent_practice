<?php

$wordsize = 16;
$memory = [];
$memsize = pow(2,$wordsize)/$wordsize;
for($i = 0; $i < $memsize; $i++){
    $memory[$i] = sprintf("%016d",decbin(random_int(0,65535)));
}

bitBitJump(0);

function bitBitJump($ip) {
    global $memory, $wordsize;
    $loc = $memory[$ip];
    $val = getBitAt(bindec($loc));
    setBitAt(bindec($memory[$ip+1]),$val);
    $ip = intdiv(bindec($memory[$ip+2]),$wordsize);
    return $ip;
}

function getBitAt($loc){
    global $wordsize, $memory;
    $word_loc = intdiv($loc,$wordsize);
    $bit_loc = $loc%$wordsize;
    $word = $memory[$word_loc];
    $bit = substr($word,$bit_loc,1);
    return $bit;
}

function setBitAt($loc,$val){
    global $wordsize, $memory;
    $word_loc = intdiv($loc,$wordsize);
    $bit_loc = $loc%$wordsize;
    $word = $memory[$word_loc];
    $new_word = substr($word,0,$bit_loc) . $val . substr($word,$bit_loc + 1);
    $memory[$word_loc] = $new_word;
}

function print_memory(){
    global $memory;
    $sq = sqrt(count($memory));
    for($i = 0; $i < count($memory); $i++){
        echo sprintf("%04x",(bindec($memory[$i]))) . ' ';
        if(($i+1)%$sq == 0){
            echo "\n";
        }
    }
}

$sq = sqrt(count($memory));
?>
<html>
<head>
    <style type="text/css">
    body{
        font-family: Verdana, sans-serif;
        font-size: 10px;
    }
    td{
        height: 30px;
        width: 30px;
        border: 1px solid #000;
        margin: 1px;
        font-size: 10px;
    }
    </style>
</head>
<body>
    <table>
        <tr>
            <?php foreach($memory as $id => $cell){?>
                <td align="center"><?=sprintf("%04x",(bindec($cell)))?></td>
                <?php if(($id+1)%$sq == 0){?>
                    </tr><tr>
                <?php }?>
            <?php } ?>
        </tr>
    </table>
</body>
