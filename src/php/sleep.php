<?php


function whait_here($n){

    $multiplier = 10;
    usleep ( $n*$multiplier );
    return $n*$multiplier/1000;
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
    <title><?=basename(__FILE__)?></title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div id="container">
    <div class="head">
        <h1>Long running requests</h1>
    </div>
    <div class="results">
        <table class="table">
            <tr>
                <th>iteration</th>
                <th>sleeping </th>
            </tr>

            <?php
                for ($i=1;$i<= $n; $i++){ ?>
                <tr>
                    <td><?=$i?></td>
                    <td><?=whait_here($i)?> sec</td>
                </tr>
                <?php
                }
            ?>
        </table>
    </div>
</div>

</body>
</html>