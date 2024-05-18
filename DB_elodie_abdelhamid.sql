/*-------------------------------------------------------------------------------------*/
/*--------------------------------[ F U N C T I O N S ]--------------------------------*/
/*-------------------------------------------------------------------------------------*/

-- calculate the new price of an item after the discount

create FUNCTION calculatePriceAfterDiscount (@oldPrice int, @discount int, @quantity int)
RETURNS int
as
begin
	declare @newPrice int;
	set @newPrice = (@oldPrice - (@oldPrice * @discount / 100)) * @quantity;
	return @newPrice;
end;
go;
-- calculate total price of an order 


create function orderTotalPrice(@orderId int)
returns int
as
begin
	declare @totalPrice int;
	select @totalPrice = sum(list_price)
	from order_items 
	where order_id = @OrderId;
	if @totalPrice is null
	set @totalPrice = 0
	return @totalPrice;
end;
go;


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
	if @num is null
	set @num = 0
	return @num;
end;
go;


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
go;

--find customers

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

select * from orders


                                                                                                                                                                                                              
/*---------------------------------------------------------------------------------------*/
/*--------------------------------[ P R O C E D U R E S ]--------------------------------*/
/*---------------------------------------------------------------------------------------*/

-- place an order
CREATE PROCEDURE PlaceOrder
    @customer_id INT,
    @required_date DATE,
    @staff_id INT
AS
BEGIN
	DECLARE @store_id INT;
	select @store_id = store_id from staffs where staff_id = @staff_id;
	
	DECLARE @order_status VARCHAR(20) = 'in process';

	print @customer_id ;
	print @order_status ;
	print GETDATE() ;
	print @required_date ;
	print NULL ;
	print @store_id  ;
	print @staff_id;
    INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
    VALUES (@customer_id, @order_status, GETDATE(), @required_date, NULL, @store_id, @staff_id);
END;


go;

-- place order_item
CREATE PROCEDURE PlaceOrderItem
    @product_id INT,
    @quantity INT,
    
    @discount INT
AS
BEGIN
declare @order_id int = (select top 1 order_id from orders order by order_id desc)
declare @list_price INT  =
(select dbo.calculatePriceAfterDiscount((select list_price from products where product_id = @product_id), @discount, @quantity))

    INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
    VALUES (@order_id, @product_id, @quantity, @list_price, @discount);
END;
go;

select top 1 order_id from orders order by order_id desc
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
go;


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
go;


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
go;

