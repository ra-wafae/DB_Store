<?php
$servername = "DESKTOP-MVH46IU";
$username = "";
$password = "";
$dbname = "BD_Store";

try {
    $conn = new PDO("sqlsrv:Server=$servername;Database=$dbname", $username, $password);
    // Set PDO to throw exceptions on error
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully"; // Optional: Display a message if connection is successful
} catch (PDOException $e) {
    echo "Connection faileeed: " . $e->getMessage();
}


// $dsn = 'odbc:YOUR_DSN_NAME';
// $username = 'your_username';
// $password = 'your_password';

// try {
//     $pdo = new PDO($dsn, $username, $password);
//     echo "Connected successfully!";
// } catch (PDOException $e) {
//     echo "Connection failed: " . $e->getMessage();
// }


?>
