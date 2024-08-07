use control_structures;

SELECT account_id, balance FROM accounts WHERE account_id IN (1, 3);
DESCRIBE accounts;

DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2)
);

INSERT INTO accounts (account_id, balance) VALUES 
(1, 5000.00),
(2, 15000.00),
(3, 7500.00),
(4, 2000.00);



DROP PROCEDURE IF EXISTS TransferFunds;

DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN p_source_account_id INT,
    IN p_destination_account_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_source_balance DECIMAL(10, 2);
    DECLARE v_destination_balance DECIMAL(10, 2);
    DECLARE insufficient_funds CONDITION FOR SQLSTATE '45000';
    DECLARE account_not_found CONDITION FOR SQLSTATE '45001';

    START TRANSACTION;

    SELECT balance INTO v_source_balance
    FROM accounts
    WHERE account_id = p_source_account_id;

    IF v_source_balance IS NULL THEN
        SIGNAL account_not_found SET MESSAGE_TEXT = 'Source account does not exist';
    END IF;

    SELECT balance INTO v_destination_balance
    FROM accounts
    WHERE account_id = p_destination_account_id;

    IF v_destination_balance IS NULL THEN
        SIGNAL account_not_found SET MESSAGE_TEXT = 'Destination account does not exist';
    END IF;

    IF v_source_balance < p_amount THEN
        SIGNAL insufficient_funds SET MESSAGE_TEXT = 'Insufficient funds in the source account';
    END IF;

    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_source_account_id;

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_destination_account_id;

    COMMIT;
END //

DELIMITER ;



CALL TransferFunds(1, 3, 1000.00);

SELECT * FROM accounts;

