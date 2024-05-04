/*-------------------------------------------------------------------------------------*/
/*--------------------------------[ F U N C T I O N S ]--------------------------------*/
/*-------------------------------------------------------------------------------------*/

-- calculate the new price of an item after the discount

CREATE FUNCTION priceAfterDiscount (@OrderId int)
RETURNS int
as
begin
	declare @oldPrice int;
	declare @newPrice int;
	select @oldPrice = list_price from order_items where order_id = @OrderId ;
	set @newPrice = @oldPrice - (@oldPrice * (select discount from order_items where order_id = @OrderId ) / 100);
	return @newPrice;
end;

-- calculate total price of an order 

create function orderTotalPrice(@orderId int)
returns int
as
begin
	declare @totalPrice int;
	select @totalPrice = sum(quantity * dbo.priceAfterDiscount (@OrderId))
	from order_items 
	where order_id = @OrderId;
	return @totalPrice;
end;

-- get number of specific product still in stock in a specific store

create function productStillInStock(@productId int, @storeId int)
returns int
as
begin
	declare @num int;
	select @num = quantity
    FROM stocks
    WHERE store_id = @storeId
    AND product_id = @productId;
	return @num;
end;

-- get orders from a specific customer

CREATE FUNCTION GetCustomerOrders(@customerId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM orders
    WHERE customer_id = @customerId
);

-- calculate the total sales amount for a given store over a specified period

CREATE FUNCTION CalculateTotalSalesForStore(
    @store_id INT,
    @start_date DATE,
    @end_date DATE
)
RETURNS int
AS
BEGIN
    DECLARE @total_sales int;
    
    SELECT @total_sales = COALESCE(dbo.orderTotalPrice(oi.order_id), 0)
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.store_id = @store_id
    AND o.order_date BETWEEN @start_date AND @end_date;
    
    RETURN @total_sales;
END;
                                                                                                                                                                                                              
/*---------------------------------------------------------------------------------------*/
/*--------------------------------[ P R O C E D U R E S ]--------------------------------*/
/*---------------------------------------------------------------------------------------*/

-- place an order
CREATE PROCEDURE PlaceOrder
    @customer_id INT,
    @order_status VARCHAR(20),
    @order_date DATE,
    @required_date DATE,
    @shipped_date DATE,
    @store_id INT,
    @staff_id INT
AS
BEGIN
    INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
    VALUES (@customer_id, @order_status, @order_date, @required_date, @shipped_date, @store_id, @staff_id);
END;

-- place order_item
CREATE PROCEDURE PlaceOrderItem
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @list_price INT,
    @discount INT
AS
BEGIN
    INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
    VALUES (@order_id, @product_id, @quantity, @list_price, @discount);
END;


-- update stock quantity for a product in a store (adding products)
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


-- update stock quantity in a store (removing products)
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


-- add an new product
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


