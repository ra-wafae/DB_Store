<?php
require_once("./db_connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $tableName = $_POST['table'];
    $statement = $_POST['statement'];
    unset( $_POST['statement'], $_POST['table']);

    // Get column names of the selected table
    $query = "SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = '$tableName' 
    
    EXCEPT
    
    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS [tc]
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE [ku] ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
        AND ku.table_name = '$tableName' and tc.CONSTRAINT_TYPE = 'PRIMARY KEY'";
    $stmt = $conn->prepare($query);
    
    $stmt->execute();
    $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);

    // Display form fields based on the selected statement and table
    echo '<h3>Enter ' . $statement . ' Statement for ' . $tableName . '</h3>';
    echo '<input type="hidden" name="tableName" value="' . $tableName . '">';
    echo '<input type="hidden" name="statement" value="' . $statement . '">';
    foreach ($columns as $column) {
        echo '<label for="' . $column . '">' . $column . ':</label>';
        echo '<input type="text" id="' . $column . '" name="' . $column . '"><br>';
    }
}
?>
