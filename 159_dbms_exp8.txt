USE db;
Database changed

CREATE TABLE customers (
    id      NUMBER PRIMARY KEY,
    name    VARCHAR2(50),
    address VARCHAR2(100),
    salary  NUMBER(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES (1, 'John', 'New York', 5500.00);
INSERT INTO customers (id, name, address, salary) VALUES (2, 'Alice', 'Los Angeles', 6500.00);
INSERT INTO customers (id, name, address, salary) VALUES (3, 'Bob', 'Chicago', 5000.00);
INSERT INTO customers (id, name, address, salary) VALUES (4, 'David', 'Houston', 7500.00);
INSERT INTO customers (id, name, address, salary) VALUES (5, 'Emma', 'Boston', 6000.00);

SELECT * FROM customers;
Customers Table
+----+-------+-------------+---------+
| id | name  | address     | salary  |
+----+-------+-------------+---------+
|  1 | John  | New York    | 5500.00 |
|  2 | Alice | Los Angeles | 6500.00 |
|  3 | Bob   | Chicago     | 5000.00 |
|  4 | David | Houston     | 7500.00 |
|  5 | Emma  | Boston      | 6000.00 |
+----+-------+-------------+---------+

-- PREDEFINED EXCEPTION HANDLING
DECLARE
    c_id   customers.id%TYPE := 5;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT name, address
    INTO   c_name, c_addr
    FROM   customers
    WHERE  id = c_id;

    DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

Enter value for c_id = 5
Name: Emma
Address: Boston

-- USER-DEFINED EXCEPTION HANDLING
DECLARE
    c_id          customers.id%TYPE := 3;
    c_name        customers.name%TYPE;
    c_addr        customers.address%TYPE;
    ex_invalid_id EXCEPTION;
BEGIN
    IF c_id <= 0 THEN
        RAISE ex_invalid_id;
    ELSE
        SELECT name, address
        INTO   c_name, c_addr
        FROM   customers
        WHERE  id = c_id;

        DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
        DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
    END IF;
EXCEPTION
    WHEN ex_invalid_id THEN
        DBMS_OUTPUT.PUT_LINE('ID must be greater than zero!');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

Enter value for c_id: -6 
ID must be greater than zero!
