<?php
require_once("./db_connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $viewName = $_POST['view'];

    // Construct the query to fetch data from the selected view
    $query = "SELECT * FROM " . $viewName;

    try {
        $result = $conn->query($query);

        if ($result) {
            // Fetch all results
            $rows = $result->fetchAll(PDO::FETCH_ASSOC);

            if (count($rows) > 0) {
                // Output the result as a table
                echo "<table border='1'>";
                // Output table headers
                echo "<tr>";
                foreach ($rows[0] as $key => $value) {
                    echo "<th>$key</th>";
                }
                echo "</tr>";
                // Output table data
                foreach ($rows as $row) {
                    echo "<tr>";
                    foreach ($row as $value) {
                        echo "<td>$value</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "No data found in the selected view.";
            }
        } else {
            echo "Error executing query: " . $conn->errorCode();
        }
    } catch (PDOException $e) {
        echo "Error executing query: " . $e->getMessage();
    }
}
?>
