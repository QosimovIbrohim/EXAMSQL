-- --  from 1 
-- CREATE TABLE PERSONS (
--     PERSON_ID BIGINT,
--     PERSON_FIRST_NAME Text,
--     PERSON_LAST_NAME Text,
--     PERSON_BIRTH_DATE DATE,
--     PRIMARY KEY(PERSON_ID)
-- );

-- CREATE TABLE CUSTOMERS (
--     CUSTOMER_ID BIGINT,
--     CARD_NUMBER BIGINT,
--     DISCOUNT REAL,
--     CONSTRAINT FK_CUSTOMERS FOREIGN KEY (CUSTOMER_ID) REFERENCES PERSONS(PERSON_ID)
-- );

-- CREATE TABLE PERSON_CONTACTS (
--     PERSON_CONTACT_ID BIGINT,
--     PERSON_ID BIGINT,
--     CONTACT_TYPE_ID BIGINT,
--     CONTACT_VALUE Text,
--     CONSTRAINT FK_PERSON_CONTACT FOREIGN KEY(PERSON_ID) REFERENCES PERSONS(PERSON_ID),
--     CONSTRAINT FK_PERSON_TYPE FOREIGN KEY(CONTACT_TYPE_ID) REFERENCES CONTACT_TYPES(CONTACT_TYPE_ID)
-- );

-- CREATE TABLE CONTACT_TYPES (
--     CONTACT_TYPE_ID BIGINT,
--     CONTACT_TYPE_NAME BIGINT,
--     PRIMARY KEY(CONTACT_TYPE_ID)
-- );

-- CREATE TABLE LOCATION_CITY (
--     CITY_ID BIGINT,
--     CITY Text,
--     COUNTRY Text,
--     PRIMARY KEY (CITY_ID)
-- );

-- CREATE TABLE LOCATIONS (
--     LOCATION_ID BIGINT,
--     LOCATION_ADDRESS Text,
--     LOCATION_CITY_ID BIGINT,
--     PRIMARY KEY (LOCATION_ID),
--     CONSTRAINT FK_LOCATION FOREIGN KEY(LOCATION_CITY_ID) REFERENCES LOCATION_CITY(CITY_ID)
-- );

-- CREATE TABLE SUPERMARKETS (
--     SUPERMARKET_ID BIGINT,
--     SUPERMARKET_NAME Text,
--     PRIMARY KEY(SUPERMARKET_ID)
-- );

-- CREATE TABLE SUPERMARKET_LOCATIONS (
--     SUPERMARKET_LOCATION_ID BIGINT,
--     SUPERMARKET_ID BIGINT,
--     LOCATION_ID BIGINT,
--     PRIMARY KEY(SUPERMARKET_LOCATION_ID),
--     CONSTRAINT FK_SUPERMARKET_ID FOREIGN KEY(SUPERMARKET_ID) REFERENCES SUPERMARKETS(SUPERMARKET_ID),
--     CONSTRAINT FK_LOCATION_ID FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID)
-- );

-- CREATE TABLE CUSTOMER_ORDERS (
--     CUSTOMER_ORDER_ID BIGINT,
--     OPERATION_TIME TIMESTAMP,
--     SUPERMARKET_LOCATION_ID BIGINT,
--     CUSTOMER_ID BIGINT,
--     PRIMARY KEY(CUSTOMER_ORDER_ID),
--     CONSTRAINT FK_SUPERMARKET_LOCATION_ID FOREIGN KEY(SUPERMARKET_LOCATION_ID) REFERENCES SUPERMARKET_LOCATIONS(SUPERMARKET_LOCATION_ID),
--     CONSTRAINT FK_CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES PERSONS(PERSON_ID)
-- );

-- CREATE TABLE PRODUCT_MANUFACTURERS (
--     MANUFACTURER_ID BIGINT,
--     MANUFACTURER_NAME Text,
--     PRIMARY KEY(MANUFACTURER_ID)
-- );

-- CREATE TABLE PRODUCT_SUPPLIERS (
--     SUPPLIER_ID BIGINT,
--     SUPPLIER_NAME Text,
--     PRIMARY KEY(SUPPLIER_ID)
-- );

-- CREATE TABLE PRODUCT_TITLES (
--     PRODUCT_TITLE_ID BIGINT,
--     PRODUCT_TITLE Text,
--     PRODUCT_CATEGORY_ID INT,
--     PRIMARY KEY(PRODUCT_TITLE_ID),
--     CONSTRAINT FK_PRODUCT_CATEGORY_ID FOREIGN KEY(PRODUCT_CATEGORY_ID) REFERENCES PRODUCT_CATEGORIES(CATEGORY_ID)
-- );

-- CREATE TABLE PRODUCT_CATEGORIES (
--     CATEGORY_ID BIGINT,
--     CATEGORY_NAME Text,
--     PRIMARY KEY(CATEGORY_ID)
-- );

-- CREATE TABLE SHOP_PRODUCTS (
--     PRODUCT_ID BIGINT,
--     PRODUCT_TITLE_ID BIGINT,
--     PRODUCT_MANUFACTURER_ID BIGINT,
--     PRODUCT_SUPPLIER_ID BIGINT,
--     UNIT_PRICE MONEY,
--     COMMENT Text,
--     PRIMARY KEY(PRODUCT_ID),
--     CONSTRAINT FK_PRODUCT_TITLE_ID FOREIGN KEY(PRODUCT_TITLE_ID) REFERENCES PRODUCT_TITLES(PRODUCT_TITLE_ID),
--     CONSTRAINT FK_PRODUCT_MANUFACTURER FOREIGN KEY(PRODUCT_MANUFACTURER_ID) REFERENCES PRODUCT_MANUFACTURERS(MANUFACTURER_ID),
--     CONSTRAINT FK_PRODUCT_SUPPLIER_ID FOREIGN KEY (PRODUCT_SUPPLIER_ID) REFERENCES PRODUCT_SUPPLIERS(SUPPLIER_ID)
-- );

-- CREATE TABLE CUSTOMER_ORDER_DETAILS (
--     CUSTOMER_ORDER_DETAILS_ID SERIAL,
--     CUSTOMER_ORDER_ID BIGINT,
--     PRODUCT_ID BIGINT,
--     PRICE MONEY,
--     PRICE_WITH_DISCOUNT MONEY,
--     PRODUCT_AMOUNT BIGINT,
--     CONSTRAINT FK_CUSTOMER_ORDER_DETAILS_ID FOREIGN KEY(CUSTOMER_ORDER_ID) REFERENCES CUSTOMER_ORDERS(CUSTOMER_ORDER_ID),
--     CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES SHOP_PRODUCTS(PRODUCT_ID)
-- );
-- to 10

-- 13
-- UPDATE shop_products
-- SET unit_price = unit_price * 1.1
-- WHERE product_title_id in (
--     SELECT product_title_id
--     FROM product_titles
--     WHERE product_category_id IN (
--         SELECT category_id
--         FROM product_categories
--         WHERE category_name = 'grocery'
--     )
-- )

-- 14
-- SELECT P.PERSON_FIRST_NAME ||  ' ' || ' ' || P.PERSON_LAST_NAME AS CUSTOMER_FULL_NAME, AVG(COD.PRICE) AS AVERAGE_PURCHASE FROM CUSTOMER_ORDERS CO 
-- JOIN PERSONS P ON CO.CUSTOMER_ID = P.PERSON_ID
-- JOIN  CUSTOMER_ORDER_DETAILS COD ON CO.CUSTOMER_ORDER_ID = COD.CUSTOMER_ORDER_ID
-- WHERE COD.PRICE > 200000 GROUP BY P.PERSON_FIRST_NAME, P.PERSON_LAST_NAME ORDER BY AVERAGE_PURCHASE DESC, CUSTOMER_FULL_NAME;


-- 15
-- select customer_order_detail_id, customer_order_id, product_id, price, price_with_discount, product_amount from customer_order_details
-- inner join customer_orders using(customer_order_id)
-- inner join customers c using(customer_id)
-- inner join persons p on p.person_id = c.customer_id
-- where extract(year from p.person_birth_date) between 2000 and 2005;

--17-savol
--insert into product_categories(category_id,category_name) values(19,'unusual')
--insert into product_titles(product_title_id,product_title,product_category_id) values(365,'zor narsa bu',19)
--insert into product_suppliers(supplier_id,supplier_name) values(27,'Ozodbek')
--insert into product_manufacturers(manufacturer_id,manufacturer_name) values(17,'Namanganlik')
--insert into shop_products(product_id,product_title_id,product_manufacturer_id,product_supplier_id,unit_price,comment) 
--values(99830,121,13,42,'$200000','albatta')

 --18
--SELECT
--  product_title_id,
--  comment,
--  CASE
--    WHEN unit_price::decimal < 300 THEN 'very cheap'
--    WHEN unit_price::decimal >= 300 AND unit_price::decimal <= 750 THEN 'affordable'
--    ELSE 'expensive'
--  END AS type
--FROM  shop_products;

--20
--CREATE or replace FUNCTION GETPRODUCTLISTBYOPERATIONDATE11(OPERATIONDATE date) RETURNS TABLE (P VARCHAR(255)) LANGUAGE PlpgSql AS $$
--begin
--return query select product_titles.product_title from customer_order_details
--inner join customer_orders using(customer_order_id)
--inner join product_titles on product_titles.product_title_id= customer_order_details.product_id
--where DATE(operation_time)=operationDate;
--end;$$;
--select * from GETPRODUCTLISTBYOPERATIONDATE11('2011-03-24');

--24
--create view product_details  as
--select pt.product_title, pc.category_name, sup.supplier_name, pm.manufacturer_name  
--from shop_products as sp inner join product_titles as pt
--on sp.product_title_id=pt.product_title_id inner join product_categories as pc
--on pt.product_category_id = pc.category_id inner join product_suppliers as sup on 
--sp.product_supplier_id=sup.supplier_id inner join product_manufacturers as pm on
--sp.product_manufacturer_id = pm.manufacturer_id

--25
--create view Customer_details as
--select person_first_name|| ' ' || person_last_name as Full_name,
--person_birth_date, cu.card_number
--from persons inner join customers as cu on person_id=customer_id

