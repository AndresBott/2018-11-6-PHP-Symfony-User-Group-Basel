<?php

// https://stackoverflow.com/questions/16763322/a-formula-to-find-prime-numbers-in-a-loop
function isPrime($num) {
    //1 is not prime. See: http://en.wikipedia.org/wiki/Prime_number#Primality_of_one
    if($num == 1)
        return false;
    //2 is prime (the only even number that is prime)
    if($num == 2)
        return true;
    if($num % 2 == 0) {
        return false;
    }
    $ceil = ceil(sqrt($num));
    for($i = 3; $i <= $ceil; $i = $i + 2) {
        if($num % $i == 0)
            return false;
    }
    return true;
}

//https://stackoverflow.com/questions/15600041/php-fibonacci-sequence
function fibonacci($n,$first = 0,$second = 1){
    $fib = [$first,$second];
    for($i=1;$i<$n;$i++)
    {
        $fib[] = $fib[$i]+$fib[$i-1];
    }
    return $fib;
}

// some recursive random math calculations
function displaced_sum($n){
//    for ($i=1;$i<= 50; $i++) {
        for ($j = 1; $j <= $n; $j++) {
            $a = $n + $j;
            $b = $a + $n;
            $c = $b - $j;
            $d = $c - $n;
        }
//    }
    return $d;
}


if (isset($_GET["n"]) && !empty($_GET["n"]) && is_numeric($_GET["n"])){
    $n = $_GET["n"];
}else{
    $n = 1000;
}

?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Math.php</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div id="container">
    <div class="head">
        <h1>Making some math...</h1>
    </div>
    <div class="results">
        <table class="table">
            <tr>
                <th>Number</th>
                <th>is prime</th>
                <th>fibonacci</th>
                <th>random generated</th>
                <th>more math</th>
            </tr>

            <?php
                for ($i=1;$i<= $n; $i++){ ?>
                <tr>
                    <td><?=$i?></td>
                <?php if (isPrime($i)){ ?>
                    <td>yes</td>
                <?php } else { ?>
                    <td>-</td>
                <?php } ?>
                    <td><?=fibonacci($i)[$i]?></td>
                    <td><?=rand(0,$i)?></td>
                    <td><?=displaced_sum($i)?></td>
                </tr>
                <?php
                }
            ?>
        </table>
    </div>
</div>

</body>
</html>