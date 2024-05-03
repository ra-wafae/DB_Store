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

-- place order_item

-- update stock quantity for a product in a store (adding products)

-- update stock quantity in a store (removing products)

-- add an new product

