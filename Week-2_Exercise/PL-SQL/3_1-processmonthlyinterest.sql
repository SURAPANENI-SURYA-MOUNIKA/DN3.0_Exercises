use control_structures;


CREATE TABLE savings_accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance DECIMAL(10, 2)
);


INSERT INTO savings_accounts (account_id, customer_id, balance) VALUES 
(1, 101, 5000.00),
(2, 102, 15000.00),
(3, 103, 7500.00);

COMMIT;


DELIMITER //

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO error_log (error_message) VALUES ('An error occurred while processing monthly interest.');
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE savings_accounts
    SET balance = balance * 1.01;

    COMMIT;
END //

DELIMITER ;




CALL ProcessMonthlyInterest();
SELECT * FROM savings_accounts;



