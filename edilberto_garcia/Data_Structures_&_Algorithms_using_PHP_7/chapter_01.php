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
print $second_max;
// --------------------------------------------------------------------------





