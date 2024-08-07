use control_structures;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10, 2)
);

CREATE TABLE error_log (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_message VARCHAR(255),
    error_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO accounts (account_id, account_holder, balance) VALUES 
(1, 'Alice Johnson', 5000.00),
(2, 'Bob Brown', 3000.00);

COMMIT;


DELIMITER //

CREATE PROCEDURE SafeTransferFunds(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO error_log (error_message) VALUES ('An error occurred during the fund transfer.');
        ROLLBACK;
    END;

    START TRANSACTION;

    IF (SELECT balance FROM accounts WHERE account_id = from_account) < amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;

    UPDATE accounts SET balance = balance - amount WHERE account_id = from_account;
    UPDATE accounts SET balance = balance + amount WHERE account_id = to_account;

    COMMIT;
END //

DELIMITER ;



CALL SafeTransferFunds(1, 2, 1000.00);
SELECT * FROM accounts;



CALL SafeTransferFunds(2, 1, 5000.00);
SELECT * FROM accounts;
SELECT * FROM error_log;




