create database demo;
use demo;

create table Products (
Id int,
productCode int,
productName varchar(50),
productPrice varchar(50),
productAmount varchar(50),
productDescription varchar(50),
productStatus bit
);

call insertInfo(1, 10);

drop table Products;
select * from Products;
select count(id) from Products;

alter table Products add unique index idx_productCode (productCode);
EXPLAIN SELECT * FROM Products WHERE productCode = 119; 
alter table Products drop index idx_productCode;

create view products_view as 
select productCode, productName, productPrice, productStatus 
from products;

select * from products_view;

create or replace view products_view as 
select id, productAmount, productDescription 
from products
where productCode = 115;

Drop view products_view;

call getAll();
call editProduct();
call deleteProduct();