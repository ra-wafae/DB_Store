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


-- get number of specific product sltill in stock in a specific store

-- get orders from a specific customer






/*---------------------------------------------------------------------------------------*/
/*--------------------------------[ P R O C E D U R E S ]--------------------------------*/
/*---------------------------------------------------------------------------------------*/

-- place an order

-- place order_item

-- update stock quantity for a product in a store (adding products)

-- update stock quantity in a store (removing products)

-- add an new product

