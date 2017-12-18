<?php

$numbers = [
27,  33,  9,   32,  41,
34,  61,  20,  86,  41,
58,  10,  30,  18,  89,
59,  64,  88,  45,  34,
85,  85,  95,  87,  19];

//1: Find average of all the elements in an array
$sum = 0;
for ($i = 0 ; $i < count($numbers) ; $i++)
{
    $sum += $numbers[$i];
}
//print $sum / count($numbers);
// --------------------------------------------------------------------------

//2: Find the sum of all elements of a two dimensional array
$numbers = [
	'a' =>
	[
		63,	65,	6,	21,	76,
		76,	24,	25,	4,	29,
		3,	54,	38,	23,	40,
		68,	48,	100, 16, 20,
		67,	61,	65,	98,	84
	],
	'b' =>
	[
		74,	52,	71,	11,	36,
		16,	10,	44,	78,	44,
		39,	57,	52,	68,	90,
		76,	51,	37,	39,	48,
		38,	46,	76,	87,	50
	]
];

$sum = 0;
foreach ($numbers as $arr)
{
	foreach ($arr as $number)
	{
		$sum += $number;
	}
}
//print $sum;
// --------------------------------------------------------------------------

//3: Find the largest element in the array
$max = 0;
foreach ($numbers as $arr)
{
	foreach ($arr as $number)
	{
		$max = $number > $max ? $number : $max;
	}
}
//print $max;
// --------------------------------------------------------------------------

//4: Find the smallest element in the array
$min = 0;
foreach ($numbers as $i => $arr)
{
	foreach ($arr as $j => $number)
	{
		if ($i == 'a' && $j == 0){
			$min = $number;
		}
		$min = ($number < $min ? $number : $min);
	}
}
//print $min;
// --------------------------------------------------------------------------

//5: Find the second largest number in the array
// Yes, we should just sort the freaking list
$max = 0;
foreach ($numbers as $arr)
{
	foreach ($arr as $number)
	{
		$max = $number > $max ? $number : $max;
	}
}

$second_max = 0;
foreach ($numbers as $arr)
{
	foreach ($arr as $number)
	{
		$second_max = $number > $second_max && $number < $max ? $number : $second_max;
	}
}
//print $second_max;
// --------------------------------------------------------------------------


//6: Print all the maximas in an array

$numbers = [86,38,94,116,28,142,97,100,41,30,103,61,76,119,6,110,147,23,32,84,35,64,112,68,101,129,9,90,106,148,39,121,127,122,105,140,16,74,19,36,128,52,89,13,5,114,70,15,66,11,118,8,56,46,1,117,12,29,77,96,21,115,47,149,79,67,17,20,42,88,135,146,22,2,73,48,145,98,144,57,99,33,136,87,71,82,92,63,93,72,18,45,27,75,43,51,131,7,104,44,59,14,24,126,65,139,50,91,95,55,78,58,81,80,49,113,120,150,108,132,138,62,31,60,69,130,143,4,10,3,37,125,134,141,107,53,123,26,25,111,34,54,137,124,102,83,109,133,85,40];

$last_number = null;
for ($i = count($numbers) ; $i >= 0; $i--)
{
    if( ($last_number && $numbers[$i] > $last_number) && ($numbers[$i-1] && $numbers[$i] > $numbers[$i-1]) ){
        print $numbers[$i] . PHP_EOL;
    }

    $last_number = $numbers[$i];
}

//7: Print alternate elements in an array

foreach($numbers as $index => $number)
{
    print $index % 2 == 0 ? $number . PHP_EOL : '';
}
