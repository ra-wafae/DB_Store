-- Create the database
CREATE DATABASE BD_Store;
GO

-- Use the database
USE BD_Store;
GO

-- Create tables
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) CONSTRAINT PK_customers PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(13),
    email VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT
);
GO

CREATE TABLE stores (
    store_id INT IDENTITY(1,1) CONSTRAINT PK_stores PRIMARY KEY,
    store_name VARCHAR(20),
    phone VARCHAR(13),
    email VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT
);
GO

CREATE TABLE staffs (
    staff_id INT IDENTITY(1,1) CONSTRAINT PK_staffs PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(13),
    email VARCHAR(50),
    active VARCHAR(50),
    store_id INT,
    manager_id INT NULL
);
GO

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) CONSTRAINT PK_orders PRIMARY KEY,
    customer_id INT,
    order_status VARCHAR(20),
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT
);
GO

CREATE TABLE categories (
    category_id INT IDENTITY(1,1) CONSTRAINT PK_categories PRIMARY KEY,
    category_name VARCHAR(20)
);
GO

CREATE TABLE brands (
    brand_id INT IDENTITY(1,1) CONSTRAINT PK_brands PRIMARY KEY,
    brand_name VARCHAR(20)
);
GO

CREATE TABLE products (
    product_id INT IDENTITY(1,1) CONSTRAINT PK_products PRIMARY KEY,
    product_name VARCHAR(20),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price INT
);
GO

CREATE TABLE stocks (
    store_id INT,
    product_id INT,
    quantity INT
);
GO

CREATE TABLE order_items (
    order_id INT,
    item_id INT IDENTITY(1,1) CONSTRAINT PK_order_items PRIMARY KEY,
    product_id INT,
    quantity INT,
    list_price INT,
    discount INT
);
GO

-- Add constraints
ALTER TABLE orders
ADD CONSTRAINT FK_orders_customer_id FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);
GO

ALTER TABLE orders
ADD CONSTRAINT FK_orders_staff_id FOREIGN KEY (staff_id)
REFERENCES staffs (staff_id);
GO

ALTER TABLE orders
ADD CONSTRAINT FK_orders_store_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);
GO

ALTER TABLE staffs
ADD CONSTRAINT FK_staffs_manager_id FOREIGN KEY (manager_id)
REFERENCES staffs (staff_id);
GO

ALTER TABLE staffs
ADD CONSTRAINT FK_staffs_store_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);
GO

ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_order_id FOREIGN KEY (order_id)
REFERENCES orders (order_id);
GO

ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_product_id FOREIGN KEY (product_id)
REFERENCES products (product_id);
GO

ALTER TABLE products
ADD CONSTRAINT FK_products_category_id FOREIGN KEY (category_id)
REFERENCES categories (category_id);
GO

ALTER TABLE products
ADD CONSTRAINT FK_products_brand_id FOREIGN KEY (brand_id)
REFERENCES brands (brand_id);
GO

ALTER TABLE stocks
ADD CONSTRAINT FK_stocks_product_id FOREIGN KEY (product_id)
REFERENCES products (product_id);
GO

ALTER TABLE stocks
ADD CONSTRAINT FK_stocks_store_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);
GO

-- Add checks
ALTER TABLE customers
ADD CONSTRAINT check_phone_customers CHECK (phone LIKE '+212%');
GO

ALTER TABLE staffs
ADD CONSTRAINT check_phone_staffs CHECK (phone LIKE '+212%');
GO

ALTER TABLE staffs
ADD CONSTRAINT check_email_staff CHECK (CHARINDEX('@', email) > 0);
GO

ALTER TABLE staffs
ADD CONSTRAINT check_name_staffs CHECK (first_name NOT LIKE '%[0-9]%' AND last_name NOT LIKE '%[0-9]%');
GO

ALTER TABLE customers
ADD CONSTRAINT check_name_customers CHECK (first_name NOT LIKE '%[0-9]%' AND last_name NOT LIKE '%[0-9]%');
GO

ALTER TABLE orders
ADD CONSTRAINT check_status CHECK (order_status IN ('confirmed', 'rejected', 'in process'));
GO

ALTER TABLE order_items
ADD CONSTRAINT check_discount_range CHECK (discount >= 0 AND discount <= 100);
GO

-- Create functions
CREATE FUNCTION calculatePriceAfterDiscount (@oldPrice INT, @discount INT, @quantity INT)
RETURNS INT
AS
BEGIN
    DECLARE @newPrice INT;
    SET @newPrice = (@oldPrice - (@oldPrice * @discount / 100)) * @quantity;
    RETURN @newPrice;
END;
GO

CREATE FUNCTION orderTotalPrice(@orderId INT)
RETURNS INT
AS
BEGIN
    DECLARE @totalPrice INT;
    SELECT @totalPrice = SUM(list_price)
    FROM order_items 
    WHERE order_id = @OrderId;
    IF @totalPrice IS NULL
        SET @totalPrice = 0;
    RETURN @totalPrice;
END;
GO

CREATE FUNCTION productStillInStock(@productId INT, @storeId INT)
RETURNS INT
AS
BEGIN
    DECLARE @num INT;
    SELECT @num = quantity
    FROM stocks
    WHERE store_id = @storeId
    AND product_id = @productId;
    IF @num IS NULL
        SET @num = 0;
    RETURN @num;
END;
GO

CREATE FUNCTION CalculateTotalSalesForStore(
    @store_id INT,
    @start_date DATE,
    @end_date DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @total_sales INT;
    
    SELECT @total_sales = COALESCE(dbo.orderTotalPrice(oi.order_id), 0)
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.store_id = @store_id
    AND o.order_date BETWEEN @start_date AND @end_date;
    
    RETURN @total_sales;
END;
GO

CREATE FUNCTION FindCustomerByName(@partial_name VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        customer_id,
        first_name,
        last_name
    FROM
        customers
    WHERE
        first_name LIKE '%' + @partial_name + '%' OR
        last_name LIKE '%' + @partial_name + '%'
);
GO

-- Create procedures
CREATE PROCEDURE PlaceOrder
    @customer_id INT,
    @required_date DATE,
    @staff_id INT
AS
BEGIN
    DECLARE @store_id INT;
    SELECT @store_id = store_id FROM staffs WHERE staff_id = @staff_id;
    
    DECLARE @order_status VARCHAR(20) = 'in process';

    PRINT @customer_id;
    PRINT @order_status;
    PRINT GETDATE();
    PRINT @required_date;
    PRINT NULL;
    PRINT @store_id;
    PRINT @staff_id;

    INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
    VALUES (@customer_id, @order_status, GETDATE(), @required_date, NULL, @store_id, @staff_id);
END;
GO

CREATE PROCEDURE PlaceOrderItem
    @product_id INT,
    @quantity INT,
    @discount INT
AS
BEGIN
    DECLARE @order_id INT = (SELECT TOP 1 order_id FROM orders ORDER BY order_id DESC);
    DECLARE @list_price INT = (SELECT dbo.calculatePriceAfterDiscount((SELECT list_price FROM products WHERE product_id = @product_id), @discount, @quantity));

    INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
    VALUES (@order_id, @product_id, @quantity, @list_price, @discount);
END;
GO

CREATE PROCEDURE UpdateStockQuantity_Add
    @store_id INT,
    @product_id INT,
    @quantity INT
AS
BEGIN
    UPDATE stocks
    SET quantity = quantity + @quantity
    WHERE store_id = @store_id AND product_id = @product_id;
END;
GO

CREATE PROCEDURE UpdateStockQuantity_Remove
    @store_id INT,
    @product_id INT,
    @quantity INT
AS
BEGIN
    UPDATE stocks
    SET quantity = quantity - @quantity
    WHERE store_id = @store_id AND product_id = @product_id;
END;
GO

CREATE PROCEDURE AddNewProduct
    @product_name VARCHAR(20),
    @brand_id INT,
    @category_id INT,
    @model_year INT,
    @list_price INT
AS
BEGIN
    INSERT INTO products (product_name, brand_id, category_id, model_year, list_price)
    VALUES (@product_name, @brand_id, @category_id, @model_year, @list_price);
END;
GO

-- Create views
CREATE VIEW Customer_order AS
SELECT 
    o.order_id, 
    o.order_status, 
    o.order_date, 
    o.required_date, 
    o.shipped_date, 
    sr.store_name, 
    c.first_name + ' ' + c.last_name AS customer_full_name
FROM 
    orders o
JOIN 
    stores sr ON o.store_id = sr.store_id
JOIN 
    customers c ON o.customer_id = c.customer_id;
GO

CREATE VIEW Product_info AS
SELECT 
    p.product_name, 
    b.brand_name, 
    c.category_name, 
    p.model_year, 
    p.list_price, 
    s.quantity 
FROM 
    stocks s
JOIN products p ON s.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
JOIN categories c ON p.category_id = c.category_id;
GO


-- Trigger to automatically update stock quantity when an order item is added
CREATE TRIGGER trg_UpdateStockOnInsertOrderItem
ON order_items
AFTER INSERT
AS
BEGIN
    DECLARE @store_id INT, @product_id INT, @quantity INT;

    SELECT @store_id = o.store_id, @product_id = i.product_id, @quantity = i.quantity
    FROM inserted i
    JOIN orders o ON i.order_id = o.order_id;

    UPDATE stocks
    SET quantity = quantity - @quantity
    WHERE store_id = @store_id AND product_id = @product_id;
END;
GO

-- Trigger to update stock quantity when an order item is deleted
CREATE TRIGGER trg_UpdateStockOnDeleteOrderItem
ON order_items
AFTER DELETE
AS
BEGIN
    DECLARE @store_id INT, @product_id INT, @quantity INT;

    SELECT @store_id = o.store_id, @product_id = d.product_id, @quantity = d.quantity
    FROM deleted d
    JOIN orders o ON d.order_id = o.order_id;

    UPDATE stocks
    SET quantity = quantity + @quantity
    WHERE store_id = @store_id AND product_id = @product_id;
END;
GO

-- Trigger to log changes in the orders table
CREATE TRIGGER trg_LogOrderChanges
ON orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @order_id INT, @operation VARCHAR(10);

    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
            SET @operation = 'UPDATE';
        ELSE
            SET @operation = 'INSERT';
    END
    ELSE
    BEGIN
        SET @operation = 'DELETE';
    END

    INSERT INTO OrderLog (order_id, operation, change_date)
    SELECT ISNULL(i.order_id, d.order_id), @operation, GETDATE()
    FROM inserted i FULL OUTER JOIN deleted d ON i.order_id = d.order_id;
END;
GO

-- Trigger to ensure that the order status is only updated to allowed values
CREATE TRIGGER trg_ValidateOrderStatus
ON orders
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE order_status NOT IN ('confirmed', 'rejected', 'in process'))
    BEGIN
        RAISERROR('Invalid order status value.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT * FROM inserted)
            INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
            SELECT customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id
            FROM inserted;
        IF EXISTS(SELECT * FROM deleted)
            DELETE FROM orders WHERE order_id IN (SELECT order_id FROM deleted);
    END
END;

GO

-- Trigger to enforce email format for staffs table
CREATE TRIGGER trg_ValidateStaffEmail
ON staffs
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE CHARINDEX('@', email) = 0)
    BEGIN
        RAISERROR('Invalid email format.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT * FROM inserted)
            INSERT INTO staffs (first_name, last_name, phone, email, active, store_id, manager_id)
            SELECT first_name, last_name, phone, email, active, store_id, manager_id
            FROM inserted;
        IF EXISTS(SELECT * FROM deleted)
            DELETE FROM staffs WHERE staff_id IN (SELECT staff_id FROM deleted);
    END
END;

GO

-- Trigger to ensure the phone number format for customers table
CREATE TRIGGER trg_ValidateCustomerPhone
ON customers
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE phone NOT LIKE '+212%')
    BEGIN
        RAISERROR('Invalid phone number format.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT * FROM inserted)
            INSERT INTO customers (first_name, last_name, phone, email, street, city, state, zip_code)
            SELECT first_name, last_name, phone, email, street, city, state, zip_code
            FROM inserted;
        IF EXISTS(SELECT * FROM deleted)
            DELETE FROM customers WHERE customer_id IN (SELECT customer_id FROM deleted);
    END
END;

GO
