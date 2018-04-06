<?php
include 'grid.php';

$g = new Grid();
$g->__init();
for($i = 0; $i < 10; $i++){
    $g->tick();
    sleep(1);
}
