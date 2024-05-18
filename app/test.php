<?php
require_once("./db_connection.php");
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Global</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="HTML5 website template">
  <meta name="keywords" content="global, template, html, sass, jquery">
  <meta name="author" content="Bucky Maler">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
  <link rel="stylesheet" href="assets/css/main.css">
</head>

<body>


  <div class="perspective effect-rotate-left">
    <div class="container">
      <div class="outer-nav--return"></div>
      <div id="viewport" class="l-viewport">
        <div class="l-wrapper">
          <header class="header">
            <a class="header--logo" href="#0">
              <img src="assets/img/logo.png" alt="Global">
              <p>ELODIE</p>
            </a>
            <button class="header--cta cta">HirS e Us</button>
            <div class="header--nav-toggle">
              <span></span>
            </div>
          </header>
          <nav class="l-side-nav">
            <ul class="side-nav">
              <li class="is-active"><span>intro</span></li>
              <li><span>SELECT TABLE</span></li>
              <li><span>TEST CONSTRAINT</span></li>
              <li><span>FUNCTIONS TEST</span></li>
              <li><span>FUNCTIONS TEST 2</span></li>
              <li><span>customer</span></li>
            </ul>
          </nav>
          <ul class="l-main-content main-content">
            <li class="l-section section section--is-active">
              <div class="intro">
                <div class="intro--banner">
                  <h1>GENERAL<br>data base<br>test</h1>

                  <span class="btn-background"></span>
                  </button>
                  <img src="assets/img/introduction-visual.png" alt="Welcome">
                </div>
                <div class="intro--options">
                  <a href="#0">
                    <h3>select tables</h3>
                    <p>we will select the tables in this database to show the result</p>
                  </a>
                  <a href="#0">
                    <h3>test the CONSTRAINT</h3>
                    <p>we will test the CONSTRAINT of this data base if they work or not</p>
                  </a>
                  <a href="#0">
                    <h3>test functions</h3>
                    <p>we will test the functions of the database to get the result</p>
                  </a>
                </div>
              </div>
            </li>
            <li class="l-section section">
              <div class="work">
                <h2>Selected work</h2>
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
              </div>
            </li>
            <li class="l-section section">
              <div class="about">
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
              </div>
            </li>
            <li class="l-section section">
              <div class="hire">
                
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
                
              </div>
            </li>
            <li class="l-section section">
              <div class="hire">
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
              </div>
            </li>
            <li class="l-section section">
              <div class="hire">
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
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <ul class="outer-nav">
      <li class="is-active">intro</li>
      <li>SELECT TABLE</li>
      <li>TEST CONSTRAINT</li>
      <li>FUNCTIONS TEST</li>
      <li>FUNCTIONS TEST 2</li>
      <li>customer</li>
    </ul>
  </div>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
  <script>
    window.jQuery || document.write('<script src="assets/js/vendor/jquery-2.2.4.min.js"><\/script>')
  </script>
  <script src="assets/js/functions-min.js"></script>
  <div id="responseDialog" title="Function Response" style="display:none;">
    <p id="responseMessage"></p>
  </div>
  <div id="dialog" title="Query Results"></div>

  <script>
    $(document).ready(function() {
      $(".table-select-card").click(function() {
        var tableName = $(this).data("table");
        $.ajax({
          url: 'selectTable.php',
          method: 'POST',
          data: {
            table_name: tableName
          },
          success: function(response) {
            $("#dialog").html(response).dialog({
              width: 1000, // Set the width of the dialog
              height: 600 // Set the height of the dialog
            });
          }
        });
      });
    });

    $(document).ready(function() {
      $("#insertForm").submit(function(event) {
        event.preventDefault(); // Prevent default form submission

        // Get form data
        var formData = $(this).serialize();

        // Send AJAX request to PHP script
        $.ajax({
          url: 'insert_data.php',
          method: 'POST',
          data: formData,
          success: function(response) {
            var responsePageUrl = 'response_page.php?message=' + encodeURIComponent(response);

            // Open the response page in a new tab
            window.open(responsePageUrl, '_blank');
          }
        });
      });

      // Load form fields based on the selected table
      $("#table").change(function() {
        var tableName = $(this).val();
        var statement = $("#Statement").val();

        $.ajax({
          url: 'load_form_fields.php',
          method: 'POST',
          data: {
            table: tableName,
            statement: statement
          },
          success: function(response) {
            $("#putValues").html(response);
          }
        });
      });
    });
  </script>
  <script>
    $(document).ready(function() {
      $(".functionForm").submit(function(event) {
        event.preventDefault(); // Prevent the form from submitting the traditional way

        // Collect form data
        var formData = $(this).serialize();

        // Send AJAX request
        $.ajax({
          url: 'execute_function.php', // Server-side script to handle the query execution
          method: 'POST',
          data: formData,
          success: function(response) {
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