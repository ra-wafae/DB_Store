<?php
require_once("./db_connection.php");
$customer_id = $_GET["customer_id"];
$required_date = $_GET["required_date"];



$query = "exec PlaceOrder $customer_id, '$required_date', 1;";
$conn->query($query);
// Function to get the selected products with quantities and discounts from the URL parameters
function getSelectedProducts(PDO $conn) {
    $selectedProducts = array();

    // Iterate through URL parameters
    foreach ($_GET as $key => $value) {
        // Check if the parameter corresponds to a product checkbox
        if (strpos($key, 'prod') === 0 && $value === 'on') {
            // Get the product ID from the parameter
            $productId = substr($key, 4);
            // Get the quantity from the corresponding qua_prod parameter
            $quantity = isset($_GET['qua_prod'.$productId]) ? $_GET['qua_prod'.$productId] : '';
            // Get the discount from the corresponding discount parameter
            $discount = isset($_GET['descount_'.$productId]) ? $_GET['descount_'.$productId] : '';

            // Add the product ID, quantity, and discount to the selectedProducts array
            
            $selectedProducts[] = array(
                'product_id' => $productId,
                'quantity' => $quantity,
                'discount' => $discount
            );
            $query = "exec PlaceOrderItem $productId, $quantity, $discount;";
            $conn->query($query);
        }
    }

    return $selectedProducts;
}


// Example usage
$selectedProducts = getSelectedProducts($conn);



 




header("location:staff.php");

