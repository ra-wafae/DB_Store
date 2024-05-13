<?php
require_once("./db_connection.php");
$storeId = (int)$_GET["store_id"];  
$query = "select * from stores where store_id = " . $storeId . ";";
$store_result = $conn->query($query)->fetch(PDO::FETCH_ASSOC);


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store </title>
</head>
<body>
    <h1>Welcome to <?php echo $store_result["store_name"]; ?></h1>
    <section class="store-main-section">
        <div class="store-main-section-left">
            <h4>store info</h4>
            <table>
                <tr>
                    <td>name :</td> <td><?php echo $store_result["store_name"]; ?></td>
                </tr>
                <tr>
                    <td>phone :</td> <td><?php echo $store_result["phone"]; ?></td>
                </tr>
                <tr>
                    <td>email :</td> <td><?php echo $store_result["email"]; ?></td>
                </tr>
                <tr>
                    <td>street :</td> <td><?php echo $store_result["street"]; ?></td>
                </tr>
                <tr>
                    <td>city :</td> <td><?php echo $store_result["city"]; ?></td>
                </tr>
                <tr>
                    <td>state :</td> <td><?php echo $store_result["state"]; ?></td>
                </tr>
                <tr>
                    <td>zip_code :</td> <td><?php echo $store_result["zip_code"]; ?></td>
                </tr>
            </table>
        </div>
        <div class="store-main-section-right">
        <?php
// Execute the SQL query to fetch item information
$items_query = "SELECT 
    p.product_name, 
    b.brand_name, 
    c.category_name, 
    p.model_year, 
    p.list_price, 
    s.quantity 
FROM 
    stocks s  
JOIN 
    products p ON s.product_id = p.product_id 
JOIN 
    brands b ON b.brand_id = p.brand_id 
JOIN 
    categories c ON c.category_id = p.category_id 
WHERE 
    s.store_id = 1";

$items_result = $conn->query($items_query);

// Check if there are any items found
if ($items_result !== false && $items_result->fetch(PDO::FETCH_ASSOC) !== false) {
    // Reset the result pointer back to the beginning
    $items_result->execute();

    // Output item details
    while ($items_row = $items_result->fetch(PDO::FETCH_ASSOC)) {
        ?>
        <!-- Item card -->
        <div class="item-card">
            <h2><?php echo $items_row['product_name']; ?></h2>
            <p><strong>Brand:</strong> <?php echo $items_row['brand_name']; ?></p>
            <p><strong>Category:</strong> <?php echo $items_row['category_name']; ?></p>
            <p><strong>Model Year:</strong> <?php echo $items_row['model_year']; ?></p>
            <p><strong>List Price:</strong> <?php echo $items_row['list_price']; ?></p>
            <p><strong>Quantity:</strong> <?php echo $items_row['quantity']; ?></p>
            <!-- Add more item details here -->
        </div>
        <?php
    }
} else {
    // No items found
    echo "No items found.";
}
?>

        </div>
    </section>

    
</body>
</html>