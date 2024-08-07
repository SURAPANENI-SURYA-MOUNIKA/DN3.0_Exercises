use control_structures;

DROP PROCEDURE IF EXISTS AddNewCustomer;
DROP PROCEDURE IF EXISTS UpdateCustomerDetails;
DROP FUNCTION IF EXISTS GetCustomerBalance;

DELIMITER //

CREATE PROCEDURE AddNewCustomer(
    IN p_customer_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_loan_interest_rate DECIMAL(5, 2),
    IN p_balance DECIMAL(15, 2)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE customer_id1 = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer ID already exists';
    ELSE
        INSERT INTO Customers (customer_id1, name, age, loan_interest_rate, balance)
        VALUES (p_customer_id, p_name, p_age, p_loan_interest_rate, p_balance);
    END IF;
END //

CREATE PROCEDURE UpdateCustomerDetails(
    IN p_customer_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_loan_interest_rate DECIMAL(5, 2),
    IN p_balance DECIMAL(15, 2)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer ID does not exist';
    ELSE
        UPDATE Customers
        SET name = p_name,
            age = p_age,
            loan_interest_rate = p_loan_interest_rate,
            balance = p_balance
        WHERE customer_id = p_customer_id;
    END IF;
END //




SHOW FUNCTION STATUS WHERE Db = 'use control_structures;
' AND Name = 'GetCustomerBalance';

SELECT * FROM Customers WHERE customer_id = 1;



SELECT GetCustomerBalance(1);



INSERT INTO Customers (customer_id, name, age, loan_interest_rate, balance)
VALUES (1, 'Jane Doe', 45, 5.5, 2000.00);



DELIMITER //

CREATE FUNCTION GetCustomerBalance(
    p_customer_id INT
) RETURNS DECIMAL(15, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_balance DECIMAL(15, 2);
    
    SELECT balance INTO v_balance
    FROM Customers
    WHERE customer_id = p_customer_id;
    
    IF v_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer ID does not exist';
    END IF;
    
    RETURN v_balance;
END //

DELIMITER ;

SELECT GetCustomerBalance(1);
