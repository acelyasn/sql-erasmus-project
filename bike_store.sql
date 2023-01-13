CREATE TABLE stores (
	store_id INT PRIMARY KEY,
	store_name VARCHAR (50) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (50),
	street VARCHAR (50),
	city VARCHAR (50),
	zip_code VARCHAR (5)
);

     
CREATE TABLE staff (
	staff_id INT PRIMARY KEY,
	branch_id INT,
	fname VARCHAR (50) NOT NULL,
	lname VARCHAR (50) NOT NULL,
	email VARCHAR (50) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active INT NOT NULL,
	store_id INT NOT NULL,
	supervisor_id INT,
	FOREIGN KEY (store_id) REFERENCES stores (store_id)
    

);

CREATE TABLE branch(
    branch_id INT,
    branch_name VARCHAR(40),
    mng_start_date DATE NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES staff (supervisor_id)

);

CREATE TABLE bike_type (
	type_id INT PRIMARY KEY,
	type_name VARCHAR (50) NOT NULL
);

CREATE TABLE bike_brands (
	brand_id INT PRIMARY KEY,
	brand_name VARCHAR (50) NOT NULL
);


CREATE TABLE bike_info (
	bike_id INT PRIMARY KEY,
	bike_name VARCHAR (50) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	year INT NOT NULL,
	price DECIMAL (5, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES bike_type (type_id), 
	FOREIGN KEY (brand_id) REFERENCES bike_brands (brand_id)
);

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	fname VARCHAR (50) NOT NULL,
	lname VARCHAR (50) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (50) NOT NULL,
	street VARCHAR (50),
	city VARCHAR (50),
	zip_code VARCHAR(50)
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_status INT NOT NULL,
	-- Order status: 1 = Awaiting approval 2 = Processing 3 = Canceled 4 = Completed
	order_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id), 
	FOREIGN KEY (store_id) REFERENCES stores (store_id),
	FOREIGN KEY (staff_id) REFERENCES staff (staff_id) 
);

CREATE TABLE ordered_items(
	order_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL (10, 2) NOT NULL,
	PRIMARY KEY (order_id),
	FOREIGN KEY (order_id) REFERENCES orders (order_id),
	FOREIGN KEY (product_id) REFERENCES bike_info (bike_id) 
);

CREATE TABLE bike_stocks (
	store_id INT,
	bike_id INT,
	quantity INT,
	PRIMARY KEY (store_id, bike_id),
	FOREIGN KEY (store_id) REFERENCES stores (store_id),
	FOREIGN KEY (bike_id) REFERENCES bike_info (bike_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

--inserts

--shops
INSERT INTO stores(store_id, store_name, phone, email, street, city, zip_code)
VALUES(100,'HappyBike','+48 504 982 043','happybikes@bikes.shop','Mogilska 51', 'Krakow',31545),
      (110,'Silver Board','+48 731 609 774','silver_board@bikes.shop','Olszańska 11','Krakow',31513),
      (120,'TSL - Rowery Elektryczne FAT BIKE','+48 575 847 797','fattybikes@bikes.shop','Kosynierów 5', 'Krakow',31527);

SELECT store_name, street FROM stores;


--customers
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(43,'Aleyna','Uçak','+1 845 407 9524','asureler@gmail.com','Argyle Ave. 14 ','New City',10956);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(1250,'Eden','Schreiner',NULL,'edenfromparadise@aol.com','Münsterstraße 69','Vechta',49377);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(666,'Alperen','Duran',NULL,'nazillili@gmail.com','Stanisława Skarżyńskiego 5','Krakow',31866);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(55,'Açelya','Şen',NULL,'acelyasen@gmail.com','Stanisława Skarżyńskiego 5','Krakow',31866);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(44,'Büşra','Akdere','+90 554 977 2696','busraakdere@gmail.com','Stanisława Skarżyńskiego 5','Krakow',31866);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(123,'Tajuana','Rollins',NULL,'tajuana.rollins@msn.com','Creek Street 154','Oswego',13126);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(109,'Thad','Castro','+1 631 943 1407','thad.castro@msn.com','Surrey Ave. 175 ','Brentwood',11717);
INSERT INTO customers(customer_id,fname, lname, phone, email, street, city, zip_code) VALUES(110,'Tena','Huber',NULL,'tena.huber@gmail.com','East Littleton St. 185 ','Newburgh',12550);
INSERT INTO customers(customer_id,fname,Lname, phone, email, street, city,  zip_code) VALUES(1035,'Dori','Alvarez',NULL,'dori.alvarez@outlook.com','Brandywine St. 8223 ','Kingston',12401);

SELECT customer_id, fname, email FROM customers
ORDER BY customer_id;

--bikes
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(11,'Surly Straggler 650b',8,4,2016,1680.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(186,'Trek CrossRip+',9,5,2018,4499.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(69,'Sun Bicycles Cruz 7',7,3,2017,416.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(95,'Electra Amsterdam Original 3i',1,3,2017,659.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(77,'Sun Bicycles Atlas X-Type',7,3,2017,416.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(12,'Electra Townie Original 21D',1,3,2006,239.99);
INSERT INTO bike_info(bike_id, bike_name, brand_id, category_id, year, price) VALUES(13,'Electra Cruiser 1 (24-Inch)',1,3,2016,269.99);


SELECT bike_name, year,price FROM bike_info
ORDER BY brand_id;

SELECT bike_name, price FROM bike_info
WHERE price < 500;

--bike types
INSERT INTO bike_type(type_id,type_name) VALUES(3,'Cruisers Bicycles');
INSERT INTO bike_type(type_id,type_name) VALUES(4,'Cyclocross Bicycles');
INSERT INTO bike_type(type_id,type_name) VALUES(5,'Electric Bikes');


--stock
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,186,6);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,69,23);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,11,22);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,13,0);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,12,8);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,95,0);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(100,77,11);

INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,186,0);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,69,10);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,11,15);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,13,3);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,12,9);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,95,7);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(110,77,21);

INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,186,2);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,69,30);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,11,10);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,13,7);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,12,15);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,95,6);
INSERT INTO bike_stocks(store_id, bike_id, quantity) VALUES(120,77,0);



--staff
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(1,1,'Fab','Jackson','fab.jackson@bikes.shop','+48 831 555 5554',1,1,2);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(2,1,'Fahd','Jaff','fahd.jaff@bike.shop','+48 555 555 5555',1,1,NULL);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(3,3,'Coma','Gene','coma.gene@bike.shop','+90 111 555 6666',1,1,6);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(4,2,'Angela','Merkel','bye.merkel@bike.shop','+49 333 555 2222',1,3,6);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(5,2,'Ted','Cruz','zodiac.killer@bike.shop','+1 516 379 4444',1,2,6);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(6,3,'Bernie','Sanders','bernie.ftw@bike.shop','+1 023 333 4444',1,2,NULL);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(7,3,'Abi','Gale','abig@bike.shop','+90 222 555 6666',1,1,6);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(8,1,'Patrick','Star','patrick.star@bike.shop','+49 333 333 3333',1,3,2);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(9,1,'Teddy','Johnson','teddy.johnson@bike.shop','+1 000 000 4444',1,2,2);
INSERT INTO staff(staff_id, branch_id, fname, lname, email, phone, active, store_id, supervisor_id) VALUES(10,2,'Sara','Michaels','sara.michaels@bike.shop','+1 093 005 4444',1,2,4);

SELECT staff_id, fname, supervisor_id FROM staff
ORDER BY supervisor_id;



--branches
INSERT INTO branch(branch_id, branch_name, mng_start_date, manager_id) VALUES(1,'Sales','2017-06-03',2);
INSERT INTO branch(branch_id, branch_name, mng_start_date, manager_id) VALUES(2,'Repair','2021-12-04',4);
INSERT INTO branch(branch_id, branch_name, mng_start_date, manager_id) VALUES(3,'Customer Service','2019-02-07',6);


--brands
INSERT INTO bike_brands(brand_id,brand_name) VALUES(100,'Electra');
INSERT INTO bike_brands(brand_id,brand_name) VALUES(101,'Trek');
INSERT INTO bike_brands(brand_id,brand_name) VALUES(102,'Sun Bicycles');
INSERT INTO bike_brands(brand_id,brand_name) VALUES(103,'Surly');


--orders
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(500,1250,4,'2020-01-15','2020-01-18',2,2);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(501,666,4,'2020-01-16','2020-01-17',1,2);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(400,43,3,'2020-04-29',NULL,3,8);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(423,55,3,'2020-04-30',NULL,2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(424,109,3,'2020-10-30',NULL,2,6);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(525,666,1,'2021-12-17',NULL,2,7);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(526,123,1,'2021-12-01',NULL,3,10);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(527,109,1,'2021-11-30',NULL,2,3);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(405,666,4,'2018-06-17','2018-06-25',2,7);
INSERT INTO orders(order_id, customer_id, order_status, order_date, shipped_date, store_id, staff_id) VALUES(300,44,4,'2018-07-01','2018-07-10',3,10);


SELECT order_id, customer_id, order_date FROM orders
ORDER BY order_date;

--ordered items
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(500,10,2,1549.00);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(501,16,3,599.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(400,10,2,1549.00);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(423,18,1,449.00);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(424,12,2,549.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(525,20,1,599.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(526,26,2,599.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(527,24,1,549.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(405,22,2,269.99);
INSERT INTO ordered_items(order_id, product_id, quantity, price) VALUES(300,6,1,469.99);
 

SELECT order_date, order_id, shipped_date, CASE order_status 
WHEN 1 THEN 'Awaiting' 
WHEN 2 THEN 'Processing' WHEN 3 THEN 'Canceled' 
WHEN 4 THEN 'Completed' END as status
FROM orders
ORDER BY order_date;

--who number 6 supervises 
SELECT fname FROM staff
WHERE supervisor_id = 6;


--joins

--who is the manager of which branch
SELECT staff.staff_id, staff.fname, branch.branch_name
FROM staff
JOIN branch 
ON staff.staff_id = branch.manager_id;

--who has which manager
SELECT staff.fname, branch.manager_id
FROM staff
JOIN branch
ON staff.supervisor_id = branch.manager_id
ORDER BY supervisor_id;


--bike names and their types
SELECT bike_info.bike_name, bike_type.type_name
FROM bike_info
JOIN bike_type
ON bike_info.category_id = bike_type.type_id;


--who have sold more than 550 bucks (nested)

SELECT staff.staff_id, staff.fname, staff.lname
FROM staff
WHERE staff.staff_id IN (
    SELECT orders.staff_id
    FROM orders
    WHERE orders.order_id IN (
        SELECT ordered_items.order_id
        FROM ordered_items
        WHERE price > 550
    )
);


--Fahd's customers

SELECT c.fname, c.city 
FROM customers c
WHERE c.customer_id IN(
    SELECT o.customer_id
    FROM orders o
    WHERE o.order_id IN (
        SELECT order_id FROM orders
        WHERE staff_id = 2)
);






