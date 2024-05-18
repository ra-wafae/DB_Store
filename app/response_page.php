<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Response Page</title>
    <style>
        .red-text {
            padding: 20px;
            text-decoration: underline;
            font-size: large;
            font-weight: 800;
            color: red;
        }
    </style>    
</head>
<body>
    <h1>Response Page</h1>
    <div id="response">
        <?php
        // Retrieve the response message from the query parameter
        $message = $_GET['message'] ?? '';
     // Insert <br> after "[SQL Server]"
     $message = str_replace('[SQL Server]', '[SQL Server]<br>', $message);

     // Use regular expression to set the color of the following text until a period to red
     $message = preg_replace('/(?<=\[SQL Server\]<br>)(.*?)(?=\.)/', '<span class="red-text">$1</span><br>', $message);

     
        // Display the response message
        echo $message;
        ?>
    </div>
</body>
</html>
