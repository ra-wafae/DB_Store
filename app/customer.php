<?php
require_once("db_connection.php");
// get ordes from data base
// $customer_order_query = "select o.order_id, o.order_status, o.order_date, o.required_date, o.shipped_date, sr.store_name, sf.first_name + ' ' + sf.last_name as staff_full_name from orders o , stores sr , staffs sf where o.store_id = sr.store_id and o.staff_id = sf.staff_id and o.order_id = 1;";
// $customer_order_result = $conn->query($customer_order_query);
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>customer Page</title>
</head>

<body>
    <h1>customer</h1>
    <h3>in this page we will test what the customer can do</h3>
    <section class="top-section">
        <div class="orders-list">
            <p>in this section the customer can see all his orders </p>
            <?php
            // Execute the SQL query to fetch customer order data
            $customer_order_query = "SELECT o.order_id, o.order_status, o.order_date, o.required_date, o.shipped_date, sr.store_name, sf.first_name + ' ' + sf.last_name AS staff_full_name FROM orders o, stores sr, staffs sf WHERE o.store_id = sr.store_id AND o.staff_id = sf.staff_id AND o.order_id = 1";
            $customer_order_result = $conn->query($customer_order_query);

            // Fetch the first row
            $row = $customer_order_result->fetch(PDO::FETCH_ASSOC);

            // Check if the fetched row is not empty
            if ($row) {
                // Output table header
                echo "<table border='1'>
            <tr>
                <th>Order ID</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Required Date</th>
                <th>Shipped Date</th>
                <th>Store Name</th>
                <th>Staff Name</th>
            </tr>";

                // Output data
                echo "<tr>
            <td>{$row['order_id']}</td>
            <td>{$row['order_status']}</td>
            <td>{$row['order_date']}</td>
            <td>{$row['required_date']}</td>
            <td>{$row['shipped_date']}</td>
            <td>{$row['store_name']}</td>
            <td>{$row['staff_full_name']}</td>
        </tr>";

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
</body>

</html>