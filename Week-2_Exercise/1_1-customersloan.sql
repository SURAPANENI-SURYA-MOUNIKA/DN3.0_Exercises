create database control_structures;
use control_structures;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    loan_interest_rate DECIMAL(5, 2)
);
INSERT INTO customers (customer_id, name, age, loan_interest_rate) VALUES (301, 'Abraham Sara', 65, 8.5);
INSERT INTO customers (customer_id, name, age, loan_interest_rate) VALUES (302, 'Thomas john', 45, 9.0);
INSERT INTO customers (customer_id, name, age, loan_interest_rate) VALUES (303, 'Ali winson', 70, 8.8);
INSERT INTO customers (customer_id, name, age, loan_interest_rate) VALUES (3044, 'Bob Brown', 62, 4.0);
COMMIT;
DELIMITER //

CREATE PROCEDURE ApplyDiscount()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_customer_id INT;
    DECLARE v_loan_interest_rate DECIMAL(5, 2);
    DECLARE cur CURSOR FOR 
        SELECT customer_id, loan_interest_rate
        FROM customers
        WHERE age > 60
        FOR UPDATE;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_customer_id, v_loan_interest_rate;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        UPDATE customers
        SET loan_interest_rate = loan_interest_rate * 0.99
        WHERE customer_id = v_customer_id;
    END LOOP;

    CLOSE cur;

    COMMIT;
END //

DELIMITER ;
SELECT * FROM customers;
CALL ApplyDiscount();
CALL ApplyDiscount();

SELECT * FROM customers;


