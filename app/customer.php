<?php
require_once("db_connection.php");

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <title>customer Page</title>
</head>

<body>
<?php 
        require("./header.php")
    ?>
    <h1>customer</h1>
    <h3>in this page we will test what the customer can do</h3>
    <section class="top-section">
        <div class="orders-list">
            <p >in this section the customer can see all his orders </p>
            <?php
            // Execute the SQL query to fetch customer order data
            $customer_order_query = "SELECT o.order_id, o.order_status, o.order_date, o.required_date, o.shipped_date, sr.store_name, sf.first_name + ' ' + sf.last_name AS staff_full_name FROM orders o, stores sr, staffs sf WHERE o.store_id = sr.store_id AND o.staff_id = sf.staff_id AND o.customer_id = 6";
            $customer_order_result = $conn->query($customer_order_query);

            // Fetch the first row
            $row = $customer_order_result->fetchAll(PDO::FETCH_ASSOC);

            // Check if the fetched row is not empty
            if (count($row)) {
                // Output table header
                echo "<table border='1' class=\"table table-striped table-hover\">
            <tr>
                <th>Order ID</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Required Date</th>
                <th>Shipped Date</th>
                <th>Store Name</th>
                <th>Staff Name</th>
            </tr>";
                foreach($row as $r){

                    // Output data
                    echo "<tr>
                    <td>{$r['order_id']}</td>
                    <td>{$r['order_status']}</td>
                    <td>{$r['order_date']}</td>
                    <td>{$r['required_date']}</td>
                    <td>{$r['shipped_date']}</td>
                    <td>{$r['store_name']}</td>
                    <td>{$r['staff_full_name']}</td>
                    </tr>";
                }

                // Close table
                echo "</table>";
            } else {
                // No results found
                echo "No results found.";
            }
            ?>

        </div>
        <div class="stores-liste">
            <?php
            // Execute SQL query to fetch store names
            $store_query = "SELECT store_id, store_name FROM stores";
            $store_result = $conn->query($store_query);

            // Check if there are any stores found
            if ($store_result !== false && $store_result->fetch(PDO::FETCH_ASSOC) !== false) {
                // Reset the result pointer back to the beginning
                $store_result->execute();

                // Output store cards
                while ($store_row = $store_result->fetch(PDO::FETCH_ASSOC)) {
                    $store_id = $store_row['store_id'];
                    $store_name = $store_row['store_name'];
            ?>
                    <!-- Store card -->
                    <div class="store-card">
                        <!-- Link to specific store page -->
                        <a href="store.php?store_id=<?php echo $store_id; ?>">
                            <!-- Store name as card content -->
                            <?php echo $store_name; ?>
                        </a>
                    </div>
            <?php
                }
            } else {
                // No stores found
                echo "No stores found.";
            }
            ?>

        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>