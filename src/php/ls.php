<?php



if (isset($_GET["path"]) && !empty($_GET["path"])  ){
    $path = $_GET["path"];
}else{
    $path = "./";
}

$dir    = $path;
if (is_dir($dir)){
    $files = scandir($dir);
}else{
    $files = [];
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
        <h1>content of <?=$path ?></h1>
        <h2> try ls.php?path=../</h2>
    </div>
    <div class="results">
        <table class="table">
            <tr>
                <th>File</th>
            </tr>

            <?php
            foreach ($files  as $file){
                if(is_file($path.$file)){
                    ?><tr><td><?=$file?></td></tr><?php
                }else{
                    ?><tr><td><a href="ls.php?path=<?= $path.$file ?>/"><?=$file?></a></td></tr><?php
                }

                }

            ?>
        </table>
    </div>
</div>

</body>
</html>