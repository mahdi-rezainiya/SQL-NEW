CREATE DATABASE mydb;
USE mydb;
DROP DATABASE mydb;
ALTER DATABASE mydb READ ONLY = 1;
ALTER DATABASE mydb READ ONLY = 0;
CREATE TABLE  employees(
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5 , 2),
    hire_date DATE
);
RENAME TABLE employees TO workers;
DROP TABLE employees;
ALTER TABLE employee
ADD phone_number VARCHAR(15)
ALTER TABLE employees
RENAME COLUMN phone_number TO email;
MODIFY COLUMN email VARCHAR(100);
ALTER TABLE employees
MODIFY email VARCHAR(100)
AFTER last_name;
ALTER TABLE employees
DROP COLUMN email;
INSERT INTO employees
VALUES(1 , "mahdi" , "rezainiya" , 25.50 , "2024-01-01");
SELECT first_name , last_name
FROM employees
WHERE employee_id = 1
WHERE hire_date <= "2023-01-01"
WHERE hire_date IS NULL;
WHERE hire_date IS NOT NULL;
UPDATE employees
SET hourly_pay = 10.5;
WHERE employee_id = 6;
SET hourly_pay = NULL;
DELETE FROM employees
WHERE employee_id = 6;
SET AUTOCOMMIT = OFF ;
SET AUTOCOMMIT = ON;
COMMIT;
ROLLBACK;
INSERT INTO test 
VALUES(CURRENT_DATE() , CURRENT_TIME() , NOW())
DROP TABLE test;
CREATE TABLE products(
    product_id INT;
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4 , 2)
);
ALTER TABLE products
ADD CONSTRAINT
UNIQUE(product_name);
CREATE TABLE products(
    product_id INT;
    product_name VARCHAR(25) NULL NOT,
    price DECIMAL(4 , 2)
);
CREATE TABLE employees(
    employee_id INT,
    hourly_pay DECIMAL(4 , 2),
    CHECK (hourly_pay >= 10.00)
    CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 10.00)
);
ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 20.00);
ALTER TABLE employees;
DROP CHECK chk_hourly_pay;
CREATE TABLE products(
    product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(4 , 2) DEFAULT 0
    transaction_id DATETIME DEFAULT NOW()
);
CREATE TABLE transactions(
    transaction INT PRIMARY KEY,
    amount DECIMAL (5 , 2)
);
ALTER TABLE transactions
ADD CONSTRAINT
PRIMARY KEY(transaction_id);
CREATE TABLE transactions(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5 , 2)
);
INSERT INTO transactions(amount)
VALUES(4.99);
ALTER TABLE transactions
AUTO_INCREMENT = 1000;
CREATE TABLE customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
CREATE TABLE transactions(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5 , 2)
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
SELECT *
FROM transactions INNER JOIN customers
FROM transactions LEFT JOIN customers
FROM transactions LEFT JOIN customers
ON transactions.customer_id = customers.customer_id;
SELECT COUNT(amount) AS count / "counting amount"
FROM transactions
SELECT SUM(amount)
SELECT MAX(amount)
SELECT MIN(amount)
SELECT CONCAT(first_name , " " , last_name) AS full_name
FROM employees;
ALTER TABLE employees
ADD COLUMN job VARCHAR(25) AFTER hourly_pay;
UPDATE employees 
SET job = "manager"
SET job = "asst. manager"
SET job = "cook"
WHERE employee_id = 1 ;
WHERE employee_id = 2 ;
WHERE employee_id = 3 ;
SELECT * 
FROM employees
WHERE hire_date < "2023-01-01" AND job = "cook";
SELECT * FROM employees
WHERE NOT job = "manager";
WHERE NOT job = "manager" AND NOT job = "asst. manager";
WHERE hire_date BETWEEN "2024-01-04" AND "2024-04-04";
WHERE job IN("cook" , "cashier" , "manager");
SELECT * FROM employees
WHERE first_name LIKE "s%"
WHERE first_name LIKE "%s"
WHERE first_name LIKE "_ook"
SELECT * FROM employees
ORDER BY first_name;
ORDER BY amount , customer_id;
SELECT * FROM customers
LIMIT 1 ;
SELECT * FROM customers AS a
INNER JOIN customers As b
ON a.referral_id = b.customer_id ;
CREATE VIEW employee_attendance AS
SELECT first_name , last_name
FROM employees;
SELECT * FROM employee_attendance
GROUP BY last_name DESC ;
DROP VIEW employee_attendance;
SHOW INDEXES FROM customers;
CREATE INDEX last_name_idx
ON customers(last_name);
ALTER TABLE customers
DROP INDEX last_name_idx;
SELECT first_name , last_name , hourly_pay , 
    (SELECT AVG(hourly_pay) FROM employees) AS avg_pay
FROM employees;
SELECT first_name , last_name , hourly_pay
FROM employees
WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);
SELECT first_name , last_name FROM customers
WHERE customer_id IN(
    SELECT DISTINCT customer_id FROM transactions
    WHERE customer_id IS NOT NULL
);
SET SUM(amount) , order_date
FROM transactions
GROUP BY order_date;
SELECT COUNT(amount) , customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount) > 1;
SELECT COUNT(amount) , customer_id
FROM transactions
GROUP BY customer_id WITH ROLLUP;
CREATE TABLE transactions(
    transaction_id PRIMARY KEY,
    amount DECIMAL(5 , 2),
    customer_id INT , 
    order_date DATE ,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE SET NULL    
);
ALTER TABLE transactions 
DROP FOREIGN KEY fk_customer_id;
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE SET NULL ;
ALTER TABLE transactions 
ADD CONSTRAINT fk_transaction_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE;
DELIMITER $$
CREATE PROCEDURE get_customers()
BEGIN 
SELECT * FROM customers
END $$
DELIMITER ;
CALL get_customers();
DROP PROCEDURE get_customers;
DELIMITER $$
CREATE PROCEDURE find_customer(IN id INT)
BEGIN 
SELECT * FROM customers
WHERE customer_id = id;
END $$
DELIMITER ;
CALL find_customer(1);
ALTER TABLE employees
ADD COLUMN salary DECIMAL(10 , 2) AFTER hourly_pay;
SELECT * FROM employees ;
UPDATE employees 
SET salary = hourly_pay * 2080 ;
CREATE TRIGGER before_hourly_pay_update
BEFORE UPDATE ON employees
FOR EACH ROW 
SET NEW.salary = (NEW.hourly_pay * 1000);
SHOW TRIGGERS;