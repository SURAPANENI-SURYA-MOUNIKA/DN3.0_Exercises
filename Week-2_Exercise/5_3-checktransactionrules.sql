use control_structures;

DESCRIBE Transactions;

DELIMITER //

CREATE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE v_balance DECIMAL(15, 2);
    
    IF (SELECT COUNT(*) FROM Accounts WHERE account_id = NEW.account_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account does not exist';
    END IF;
    
    SELECT account_balance INTO v_balance
    FROM Accounts
    WHERE account_id = NEW.account_id;
    
    IF NEW.transaction_type = 'DEPOSIT' AND NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deposit amount must be positive';
    END IF;
    
    IF NEW.transaction_type = 'WITHDRAWAL' AND NEW.amount > v_balance THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance for withdrawal';
    END IF;
END //

DELIMITER ;



