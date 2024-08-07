use control_structures;

DELIMITER //

CREATE PROCEDURE AddNewCustomer(
    IN p_customer_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_loan_interest_rate DECIMAL(5, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO error_log (error_message) VALUES (CONCAT('An error occurred while adding customer with ID ', p_customer_id));
        ROLLBACK;
    END;

    START TRANSACTION;

    IF EXISTS (SELECT * FROM customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer ID already exists';
    END IF;

    INSERT INTO customers (customer_id, name, age, loan_interest_rate)
    VALUES (p_customer_id, p_name, p_age, p_loan_interest_rate);

    COMMIT;
END //

DELIMITER ;




CALL AddNewCustomer(101, 'Alice Johnson', 45, 5.5);
SELECT * FROM customers;


CALL AddNewCustomer(101, 'Bob Brown', 50, 6.0);
SELECT * FROM customers;
SELECT * FROM error_log;







