<?php
require_once("./db_connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get form data
    $tableName = $_POST['tableName'];
    $statement = $_POST['statement'];
    unset($_POST['tableName'], $_POST['statement'], $_POST['table'], $_POST['Statement']);

    // Prepare the SQL query based on the statement type
    if ($statement === 'INSERT') {
        $columns = implode(', ', array_keys($_POST));
        $values = "'" . implode("', '", $_POST) . "'"; // Values wrapped in single quotes
        $sql = "INSERT INTO $tableName ($columns) VALUES ($values)";
    } else if ($statement === 'UPDATE') {
        $updates = implode(', ', array_map(function($key, $value) {
            return "$key='$value'";
        }, array_keys($_POST), $_POST));
        $sql = "UPDATE $tableName SET $updates WHERE <condition>"; // Provide a condition for the update
    }

    //Execute the query
    $result = $conn->query($sql);
    
    if ($result !== false) {
        echo "Data inserted/updated successfully!";
    } else {
        echo "Error inserting/updating data: style=\"color:red\">" . strip_tags($conn->errorCode())."</p>";
    }
}
?>
