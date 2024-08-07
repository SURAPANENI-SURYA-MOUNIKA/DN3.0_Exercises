use control_structures;

DROP PROCEDURE IF EXISTS OpenAccount;
DROP PROCEDURE IF EXISTS CloseAccount;
DROP FUNCTION IF EXISTS GetTotalBalance;

DELIMITER //

CREATE PROCEDURE OpenAccount(
    IN p_customer_id INT,
    IN p_initial_balance DECIMAL(15, 2)
)
BEGIN
    INSERT INTO Accounts (customer_id, account_balance)
    VALUES (p_customer_id, p_initial_balance);
END //

CREATE PROCEDURE CloseAccount(
    IN p_account_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE account_id = p_account_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account ID does not exist';
    ELSE
        DELETE FROM Accounts WHERE account_id = p_account_id;
    END IF;
END //




select *from Accounts;



INSERT INTO Accounts (account_id, balance,customer_id)
VALUES
    (101,  5000.00,1),
    (102,  2000.00,1),
    (103, 1500.00,2);






DROP FUNCTION IF EXISTS GetTotalBalance;





DELIMITER //

CREATE FUNCTION GetTotalBalance(
    p_customer_id INT
) RETURNS DECIMAL(15, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE v_total_balance DECIMAL(15, 2);
    
    SELECT COALESCE(SUM(balance), 0) INTO v_total_balance
    FROM Accounts
    WHERE customer_id = p_customer_id;
    
    RETURN v_total_balance;
END //

DELIMITER ;



SHOW FUNCTION STATUS WHERE Name = 'GetTotalBalance';


SELECT GetTotalBalance(101);
