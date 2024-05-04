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
manager_id int 
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
ADD CONSTRAINT store_id FOREIGN KEY (store_id)
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





