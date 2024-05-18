<?php
require_once("./db_connection.php");
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>customer Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>

<body>
<?php 
        require("./header.php")
    ?>
    <h1>staff</h1>
    <h3>in this page we will test what the staff can do</h3>
    <section class="top-section">
        <div class="orders-list">
            <p>in this section the staff can see all the orders that he placed</p>
            <?php
            // Execute the SQL query to fetch customer order data
            $customer_order_query = "SELECT o.order_id, o.order_status, o.order_date, o.required_date,
            o.shipped_date, sr.store_name, c.first_name + ' ' + c.last_name AS customer_full_name 
            FROM orders o, stores sr, customers c 
            WHERE o.store_id = sr.store_id AND o.customer_id = c.customer_id AND o.staff_id = 1";
            $customer_order_result = $conn->query($customer_order_query);
            $cuOrR = $customer_order_result->fetchAll(PDO::FETCH_ASSOC);

            // Check if the fetched row is not empty
            if (count($cuOrR) > 0) {

                // Output table header
                echo "<table border='1' class=\"table table-striped table-hover\">
            <tr>
                <th>Order ID</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Required Date</th>
                <th>Shipped Date</th>
                <th>Store Name</th>
                <th>customer Name</th>
            </tr>";
                foreach ($cuOrR as $row) {

                    // Output data
                    echo "<tr>
            <td>{$row['order_id']}</td>
            <td>{$row['order_status']}</td>
            <td>{$row['order_date']}</td>
            <td>{$row['required_date']}</td>
            <td>{$row['shipped_date']}</td>
            <td>{$row['store_name']}</td>
            <td>{$row['customer_full_name']}</td>
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
        <div class="place-order">
            <form action="./add_order.php">
                <label for="customer_id">customer id</label>
                <input type="text" name="customer_id">

                <label for="required_date">required date</label>
                <input type="date" name="required_date">

                <input type="submit" value="submit">
                
               

                <table border="1" class="table  table-hover table-striped-columns">
                    <thead>
                        <th></th>
                        <th>product name</th>
                        <th>brand</th>
                        <th>category</th>
                        <th>model</th>
                        <th>price</th>
                        <th>quantity</th>
                        <th>discount</th>
                    </thead>
                    <tbody>
                        <?php
                        $query = 'select p.product_id, product_name, brand_name, category_name, model_year, list_price, quantity
                        from products p join stocks s on s.product_id = p.product_id
                        join stores st on st.store_id = s.store_id 
                        join staffs sf on st.store_id = sf.store_id
                        left join brands b on p.brand_id = b.brand_id
                        left join categories c on p.category_id = c.category_id
                        where staff_id = 1';
                    $products = $conn->query($query);
                    $prod = $products->fetchAll(PDO::FETCH_ASSOC);
                    foreach($prod as $p)
                    {
                        echo '<tr>';
                        echo '<td><input type="checkbox" name="prod'.$p["product_id"].'"></td>';
                        echo '<td>' . $p["product_name"] . '</td>';
                        echo '<td>' . $p["brand_name"] . '</td>';
                        echo '<td>' . $p["category_name"] . '</td>';
                        echo '<td>' . $p["model_year"] . '</td>';
                        echo '<td>' . $p["list_price"] . '</td>';
                        echo '<td><input type="number" name="qua_prod'.$p["product_id"].'" min="0" max="' . $p["quantity"] . '" value="1"">/' . $p["quantity"] . '</td>';
                        echo '<td><input type="number" name="descount_'.$p["product_id"].'" min="0" max="100" value="0"></td>';
                    }
                        ?>
                    </tbody>
                </table>
            </form>


        </div>

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>