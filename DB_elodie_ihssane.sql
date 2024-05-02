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