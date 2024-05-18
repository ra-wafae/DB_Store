<?php
require_once("./db_connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $queryBase = $_POST['query'];
    $arguments = $_POST['arguments'];

    // Construct the full query with all arguments
    $query = $queryBase . "(" . implode(", ", array_map(function($arg) {
        return "'" . $arg . "'";
    }, $arguments)) . ")";



    // Execute the query
    try {
        $result = $conn->query($query);

        if ($result) {
            // Fetch all results and return them as a JSON response
            $response = $result->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($response);
        } else {
            echo "Error executing query: " . $conn->errorCode();
        }
    } catch (PDOException $e) {
        echo "Error executing query: " . $e->getMessage();
    }
}
?>
