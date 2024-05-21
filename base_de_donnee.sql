create database BD_Store;
use BD_Store;
create table customers (
customer_id int identity(1,1) constraint PK_customers primary key,
first_name varchar(20),
last_name varchar(20),
phone varchar(13),
email varchar(50),
street varchar(50),
city varchar(50),
state varchar(50),
zip_code int 
);

create table stores (
store_id int identity(1,1) constraint PK_stores primary key,
store_name varchar(20),
phone varchar(13),
email varchar(50),
street varchar(50),
city varchar(50),
state varchar(50),
zip_code int 
);

create table staffs (
staff_id  int identity(1,1) constraint PK_staffs primary key,
first_name varchar(20),
last_name varchar(20),
phone varchar(13),
email varchar(50),
active varchar(50),
store_id int ,
manager_id int NULL
);
 
 create table orders (
 order_id int identity(1,1) constraint PK_orders primary key,
 customer_id int,
 order_status varchar(20) ,
 order_date date ,
 required_date date,
 shipped_date date,
 store_id int,
 staff_id int
 );



 create table categories (
 category_id int identity(1,1) constraint PK_categories primary key,
 category_name varchar(20),
 );

 create table brands (
 brand_id int identity(1,1) constraint PK_brands primary key,
 brand_name varchar(20),
 );

 create table products (
 product_id int identity(1,1) constraint PK_products primary key,
 product_name varchar(20),
 brand_id int,
 category_id int ,
 model_year int,
 list_price int 
 );

 create table stocks (
 store_id int,
 product_id int ,
 quantity int 
 );

 create table order_items (
 order_id int ,
 item_id int identity(1,1) constraint PK_order_items primary key,
 product_id int,
 quantity int ,
 list_price int,
 discount int 
 );

  /*--------------------------------------------------------------------------------------*/
 /*--------------------------------[ C O N S T R A I N T ]-------------------------------*/
/*--------------------------------------------------------------------------------------*/
   ALTER TABLE orders
ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

ALTER TABLE orders
ADD CONSTRAINT staff_id FOREIGN KEY (staff_id)
REFERENCES staffs (staff_id);

ALTER TABLE orders
ADD CONSTRAINT store_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);

ALTER TABLE staffs
ADD CONSTRAINT manager_id FOREIGN KEY (manager_id)
REFERENCES staffs (staff_id);

ALTER TABLE staffs
ADD CONSTRAINT stores_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);

ALTER TABLE order_items
ADD CONSTRAINT order_id FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_items
ADD CONSTRAINT product_id FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE products
ADD CONSTRAINT category_id FOREIGN KEY (category_id)
REFERENCES categories (category_id);

ALTER TABLE products
ADD CONSTRAINT brand_id FOREIGN KEY (brand_id)
REFERENCES brands (brand_id);

ALTER TABLE stocks
ADD CONSTRAINT products_id FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE stocks
ADD CONSTRAINT PK_store_id FOREIGN KEY (store_id)
REFERENCES stores (store_id);

ALTER TABLE customers
ADD CONSTRAINT check_numero_telephone 
CHECK (phone LIKE '+212%');

ALTER TABLE staffs
ADD CONSTRAINT check_staff_telephone 
CHECK (phone LIKE '+212%');

ALTER TABLE staffs
ADD CONSTRAINT check_email_staff
CHECK (CHARINDEX('@', email) > 0);

ALTER TABLE staffs
ADD CONSTRAINT check_name_staffs
CHECK (
    first_name NOT LIKE '%[0-9]%' AND last_name NOT LIKE '%[0-9]%'
);

ALTER TABLE customers
ADD CONSTRAINT check_name_customer
CHECK (
    first_name NOT LIKE '%[0-9]%' AND last_name NOT LIKE '%[0-9]%'
);

ALTER TABLE orders
ADD CONSTRAINT check_status
CHECK (
   order_status IN ('confirmed', 'rejected', 'in process')
);

ALTER TABLE order_items
ADD CONSTRAINT check_discount_range 
CHECK (
    discount >= 0 AND discount <= 100
);

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


/*---------------------------------------------------------------------------------------*/
 /*-------------------------------------[ V I E W S ]------------------------------------*/
/*--------------------------------------------------------------------------------------*/

--Customer Orders View


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


	-- Showing The View 
		SELECT * FROM Customer_order;


--Product Information View

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
JOIN 
    products p ON s.product_id = p.product_id 
JOIN 
    brands b ON b.brand_id = p.brand_id 
JOIN 
    categories c ON c.category_id = p.category_id;


	-- Showing The View 
		SELECT * FROM Product_info;

--Products in Staff Store View


CREATE VIEW Products_in_Staff_Store AS
SELECT 
    p.product_id, 
    p.product_name, 
    b.brand_name, 
    c.category_name, 
    p.model_year, 
    p.list_price, 
    s.quantity 
FROM 
    products p 
JOIN 
    stocks s ON s.product_id = p.product_id
JOIN 
    stores st ON st.store_id = s.store_id 
JOIN 
    staffs sf ON st.store_id = sf.store_id
LEFT JOIN 
    brands b ON p.brand_id = b.brand_id
LEFT JOIN 
    categories c ON p.category_id = c.category_id;

	--Showing the View 
		SELECT * FROM Products_in_Staff_Store;

--Product Info for Customer View


CREATE VIEW Product_info_for_Customer AS
SELECT 
    o.order_id, 
    o.order_status, 
    o.order_date, 
    o.required_date, 
    o.shipped_date, 
    sr.store_name, 
    sf.first_name + ' ' + sf.last_name AS staff_full_name
FROM 
    orders o
JOIN 
    stores sr ON o.store_id = sr.store_id 
JOIN 
    staffs sf ON o.staff_id = sf.staff_id;

	--Showing The View
		SELECT * FROM Product_info_for_Customer;

--Store Names View


CREATE VIEW Store_names AS
SELECT 
    store_id, 
    store_name 
FROM 
    stores;

	--Showing The View
		SELECT * FROM Store_names;

--Total Sales by Store

CREATE VIEW Total_sales_by_store AS
SELECT 
    st.store_name, 
    SUM(oi.list_price * oi.quantity) AS total_sales
FROM 
    order_items oi
JOIN 
    orders o ON oi.order_id = o.order_id
JOIN 
    stores st ON o.store_id = st.store_id
GROUP BY 
    st.store_name;

	--Showing The View
		SELECT * FROM Total_sales_by_store;
