<?php
$servername = "DESKTOP-MVH46IU";
$username = "";
$password = "";
$dbname = "BD_Store";

try {
    $conn = new PDO("sqlsrv:Server=$servername;Database=$dbname", $username, $password);
    // Set PDO to throw exceptions on error
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
} catch (PDOException $e) {
    echo "<script> console.log('data base Connection faileeed: " . $e->getMessage() . ");</script>";
}





?>
