CREATE TABLE customers (
    id      INT PRIMARY KEY,
    name    VARCHAR(50),
    address VARCHAR(100),
    salary  DECIMAL(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES
(1, 'John',  'New York',    5000.00),
(2, 'Alice', 'Los Angeles', 6000.00),
(3, 'Bob',   'Chicago',     4500.00),
(4, 'David', 'Houston',     7000.00),
(5, 'Emma',  'Boston',      5500.00);


--IMPLICIT CURSOR
SET SERVEROUTPUT ON;

DECLARE
    total_rows NUMBER(2);
BEGIN
    UPDATE customers
    SET salary = salary + 500;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('no customers selected');
    ELSIF SQL%FOUND THEN
        total_rows := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(total_rows || ' customers selected ');
    END IF;
END;
/

5 customers selected

PL/SQL procedure successfully completed.

-- EXPLICIT CURSOR
DECLARE
   c_id customers.id%TYPE;
   c_name customers.name%TYPE;
   c_addr customers.address%TYPE;
   CURSOR c_customers IS
      SELECT id, name, address FROM customers;
BEGIN
   OPEN c_customers;
   LOOP
      FETCH c_customers INTO c_id, c_name, c_addr;
      EXIT WHEN c_customers%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_name || ' ' || c_addr);
   END LOOP;
   CLOSE c_customers;
END;
/

ID | NAME  | ADDRESS
---+-------+------------
1  | John  | New York
2  | Alice | Los Angeles
3  | Bob   | Chicago
4  | David | Houston
5  | Emma  | Boston
