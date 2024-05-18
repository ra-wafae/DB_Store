<?php
require_once("./db_connection.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>General Tests</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <style>
        .table-cards{
            display: flex;
        }
        .card {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<?php 
        require("./header.php")
    ?>
    <h1>General Test</h1>
    <p>In this page, we will test the database.</p>
    <section id="tables-select-section">
        <h3>Click any table card to select the data from it</h3>
        <div class="table-select-cards">
            <?php
            

            $query = 'SELECT name FROM sys.tables';
            $tables = $conn->query($query);
            while ($row = $tables->fetch(PDO::FETCH_ASSOC)) {
                echo '<div class="table-select-card" data-table="' . $row["name"] . '">
                        <div class="table-select-card-inside">
                        <h5>' . $row["name"] . '</h5>
                        </div>
                      </div>';
            }
            ?>
        </div>
    </section>
    <section id="contraint-test">
    <form id="insertForm">
            <label for="Statement">Statement</label>
            <select name="Statement" id="Statement">
                <option value="INSERT">INSERT</option>
                <option value="UPDATE">UPDATE</option>
            </select>
            <label for="table">table</label>
            <select name="table" id="table">
            <?php
            $query = 'SELECT name FROM sys.tables';
            $tables = $conn->query($query);
            while ($row = $tables->fetch(PDO::FETCH_ASSOC)) {
                echo '<option value="' . $row["name"] . '">' . $row["name"] . '</option>';
            }
            ?>
            </select>
            <div id="putValues">

            </div>
            <button type="submit">Insert Data</button>
        </form>
    </section>

    <section id="functions-test">
        <h1>Function Test</h1>
        <div class="function-card">
            <h5>calculate Price After Discount</h5>
            <p>This function calculates the total price after applying a discount based on the original price, discount percentage, and quantity.</p>
            <form class="functionForm">
                <input type="hidden" name="query" value="select dbo.calculatePriceAfterDiscount">
                <label for="arguments[]">Original Price:</label>
                <input type="number" name="arguments[]" id="arguments[]" required>
                <br>
                <label for="arguments[]">Discount Percentage:</label>
                <input type="number" name="arguments[]" id="arguments[]" required>
                <br>
                <label for="arguments[]">Quantity:</label>
                <input type="number" name="arguments[]" id="arguments[]" required>
                <br>
                <button type="submit">Calculate</button>
            </form>
        </div>
        <div class="function-card">
    <h5>Order Total Price</h5>
    <p>This function calculates the total price for a given order based on the order ID.</p>
    <form class="functionForm">
        <input type="hidden" name="query" value="SELECT dbo.orderTotalPrice">
        <label for="arguments[]">Order ID:</label>
        <input type="number" name="arguments[]" required>
        <br>
        <button type="submit">Calculate</button>
    </form>
</div>
<div class="function-card">
    <h5>Product Still In Stock</h5>
    <p>This function checks if a product is still in stock at a given store based on the product ID and store ID.</p>
    <form class="functionForm">
        <input type="hidden" name="query" value="SELECT dbo.productStillInStock">
        <label for="arguments[]">Product ID:</label>
        <input type="number" name="arguments[]" required>
        <br>
        <label for="arguments[]">Store ID:</label>
        <input type="number" name="arguments[]" required>
        <br>
        <button type="submit">Check Stock</button>
    </form>
</div>
<div class="function-card">
    <h5>Calculate Total Sales For Store</h5>
    <p>This function calculates the total sales for a store within a specified date range.</p>
    <form class="functionForm">
        <input type="hidden" name="query" value="SELECT dbo.CalculateTotalSalesForStore">
        <label for="arguments[]">Store ID:</label>
        <input type="number" name="arguments[]" required>
        <br>
        <label for="arguments[]">Start Date:</label>
        <input type="date" name="arguments[]" required>
        <br>
        <label for="arguments[]">End Date:</label>
        <input type="date" name="arguments[]" required>
        <br>
        <button type="submit">Calculate Total Sales</button>
    </form>
</div>
<div class="function-card">
    <h5>Find Customer By Name</h5>
    <p>This function retrieves the top 5 customers whose first name or last name matches the provided partial name.</p>
    <form class="functionForm">
        <input type="hidden" name="query" value="SELECT * FROM dbo.FindCustomerByName">
        <label for="arguments[]">Partial Name:</label>
        <input type="text" name="arguments[]" required>
        <br>
        <button type="submit">Find Customers</button>
    </form>
</div>
    </section>



    <div id="responseDialog" title="Function Response" style="display:none;">
        <p id="responseMessage"></p>
    </div>
    <div id="dialog" title="Query Results"></div>

    <script>
        $(document).ready(function(){
            $(".table-select-card").click(function(){
                var tableName = $(this).data("table");
                $.ajax({
                    url: 'selectTable.php',
                    method: 'POST',
                    data: {table_name: tableName},
                    success: function(response){
                        $("#dialog").html(response).dialog({
                        width: 1000, // Set the width of the dialog
                        height: 600 // Set the height of the dialog
                    });
                    }
                });
            });
        });

        $(document).ready(function(){
            $("#insertForm").submit(function(event){
                event.preventDefault(); // Prevent default form submission

                // Get form data
                var formData = $(this).serialize();

                // Send AJAX request to PHP script
                $.ajax({
                    url: 'insert_data.php',
                    method: 'POST',
                    data: formData,
                    success: function(response){
                        var responsePageUrl = 'response_page.php?message=' + encodeURIComponent(response);
        
        // Open the response page in a new tab
        window.open(responsePageUrl, '_blank');
                    }
                });
            });

            // Load form fields based on the selected table
            $("#table").change(function(){
                var tableName = $(this).val();
                var statement = $("#Statement").val();

                $.ajax({
                    url: 'load_form_fields.php',
                    method: 'POST',
                    data: {table: tableName, statement: statement},
                    success: function(response){
                        $("#putValues").html(response);
                    }
                });
            });
        });
    </script>
        <script>
       $(document).ready(function(){
            $(".functionForm").submit(function(event){
                event.preventDefault(); // Prevent the form from submitting the traditional way

                // Collect form data
                var formData = $(this).serialize();

                // Send AJAX request
                $.ajax({
                    url: 'execute_function.php', // Server-side script to handle the query execution
                    method: 'POST',
                    data: formData,
                    success: function(response){
                        // Show the response in the dialog box
                        $("#responseMessage").text(response);
                        $("#responseDialog").dialog({
                            modal: true,
                            width: 400,
                            buttons: {
                                Ok: function() {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        // Handle errors
                        alert("An error occurred: " + xhr.responseText);
                    }
                });
            });
        });
    </script>
    
    <!-- jQuery UI for dialog -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
