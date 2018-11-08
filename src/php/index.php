<?php

$scripName= basename(__FILE__);
$serverSoftware = $_SERVER["SERVER_SOFTWARE"];
$userName = exec('whoami');
$host = $_SERVER["HTTP_HOST"];
$hostname = explode(":",$host)[0];
$cwd = getcwd();

//error_reporting(E_ALL);
//ini_set('display_errors', TRUE);
//

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


if (isset($_GET["pwn"]) && !empty($_GET["pwn"])  ){
    $pwn = true;
}else{
    $pwn = false;
}

?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><?= $scripName ?></title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body class="<?php if($userName == "www-data") { echo "apache"; } ?>" >
<div id="container">
    <div class="head">
        <h1><?php if($userName == "www-data") { echo "Apache2"; }else { echo "PHP-FPM"; } ?> - Demo</h1>
    </div>
    <hr>
        <h2>App info:</h2>
        <h3>
            <?php echo '$~ whoami: "<i>' .$userName .'"</i>'; ?>
        </h3>
        <h3> $~ cwd: "<i><?=$cwd ?></i>"   </h3>
        <h3> http host: "<i><?=$hostname ?></i>"   </h3>
        <h3> server sorftware: "<i><?=$serverSoftware ?></i>" </h3>

<!--        <h3>-->
<!--            --><?php
//            echo "<pre>";
////            print_r($_SERVER);
//            echo "</pre>";
//            ?>
<!--        </h3>-->


    <hr>
    <h2> Cross user exec</h2>
    <?php
    $pwnedFile = "/vhosts/phpuser1/public_html/pwned.php";
    $pwnedString = "you have been pwned!";
    if ($hostname == "php2.localhost" ){ ?>
    <h3>
        <?php

        $cmd = "echo '<?php echo \"$pwnedString\"; ?>' > $pwnedFile";
        echo "trying to shell execute: <a href=\"http://" . $host . "/" . $scripName . "?pwn=true\"> <b>" . htmlspecialchars($cmd) . "</b></a>";
        echo "<br>";
        ?>
    </h3>
    <h2 class="center">
        <?php

            if ($pwn) {
            $cmdOut = shell_exec($cmd);
            echo "executed!";
            }
        ?>
    </h2>
    <?php }else{  ?>
    <h3>
    <?="check for file: $pwnedFile"; ?>
    </h3>
    <h2 class="center">
        <?php
        if (file_exists ( $pwnedFile)){
            echo $pwnedString;
        }
    }
        ?>
    </h2>
    <hr>

    <br>
    <div class="results">
        <h2 class="">Content of: <?=$path ?></h2>
        <h3 class=""> try "<?=$scripName?>?path=../"</h3>
        <table class="narrow table">
            <tr>
                <th>File</th>
                <th>Owner</th>
                <th>Group</th>
                <th>Perms</th>
            </tr>

            <?php
            foreach ($files  as $file){
                if(is_file($path.$file)){
                    ?><tr>
                        <td><a href="http://<?=$host."/"?><?=$path.$file ?>"><?=$file?></a></td>
                        <td><?=posix_getpwuid(fileowner($file))["name"]; ?></td>
                        <td><?=posix_getgrgid(fileowner($file))["name"]; ?></td>
                        <td><?=substr(sprintf("%o",fileperms($file)),-4); ?></td>

                    </tr><?php


                }else{
                    ?><tr><td colspan="4"><a href="http://<?=$host."/".$scripName?>?path=<?= $path.$file ?>/"><?=$file?>/</a></td></tr><?php
                }

                }

            ?>
        </table>
    </div>
    <hr>
    <div class="subhead">
        <h2>Print an error:</h2>
        <h3>
        <?php
        if (true){
            echo "$dd";
        }

        ?>
        </h3>
    </div>
</div>

</body>
</html>