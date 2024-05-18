<?php
require_once("./db_connection.php");

if(isset($_POST['table_name'])) {
    $tableName = $_POST['table_name'];
    $query = 'SELECT * FROM ' . $tableName;
    $r = $conn->query($query);
    $result = $r->fetchAll(PDO::FETCH_ASSOC);
    if (count($result) > 0) {
        echo '<table border="1" class="table table-striped table-hover"><tr>';

        $query = 'SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = N\''.$tableName.'\'';
        $columns = $conn->query($query)->fetchAll(PDO::FETCH_ASSOC);
        foreach ($columns as $key) {
            echo '<th>' . $key["COLUMN_NAME"] . '</th>';
        }
        echo '</tr>';

        foreach ($result as $row) {
            echo '<tr>';
            foreach ($row as $value) {
                echo '<td>' . $value . '</td>';
            }
            echo '</tr>';
        }
        echo '</table>';
    } else {
        echo 'No data found in ' . $tableName;
    }
}
?>
