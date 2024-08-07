use control_structures;
drop table accounts;
ALTER TABLE Transactions
ADD account_id1 INT;


ALTER TABLE Customers
ADD account_id1 INT;


CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_balance DECIMAL(15, 2)
);


ALTER TABLE Transactions
ADD customer_id1 INT;

ALTER TABLE Transactions
ADD CONSTRAINT fk1_customer
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);



DROP PROCEDURE IF EXISTS GenerateMonthlyStatements;

DELIMITER //

CREATE PROCEDURE GenerateMonthlyStatements()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_transaction_id INT;
    DECLARE v_account_id INT;
    DECLARE v_transaction_date DATE;
    DECLARE v_amount DECIMAL(15, 2);
    DECLARE v_customer_name VARCHAR(100);
    
    -- Declare cursor
    DECLARE cur_transactions CURSOR FOR
        SELECT t.transaction_id, t.account_id, t.transaction_date, t.amount, c.name
        FROM Transactions t
        JOIN Customers c ON t.customer_id = c.customer_id
        WHERE t.transaction_date BETWEEN DATE_FORMAT(NOW() ,'%Y-%m-01') AND LAST_DAY(NOW());
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_transactions;
    
    read_loop: LOOP
        FETCH cur_transactions INTO v_transaction_id, v_account_id, v_transaction_date, v_amount, v_customer_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT CONCAT('Customer: ', v_customer_name) AS Statement;
        SELECT CONCAT('Transaction ID: ', v_transaction_id) AS Statement;
        SELECT CONCAT('Account ID: ', v_account_id) AS Statement;
        SELECT CONCAT('Date: ', v_transaction_date) AS Statement;
        SELECT CONCAT('Amount: ', v_amount) AS Statement;
        SELECT '----------------------------------------' AS Statement;
    END LOOP;
    
    CLOSE cur_transactions;
END //

DELIMITER ;



SHOW PROCEDURE STATUS WHERE Db = 'use control_structures';


CALL GenerateMonthlyStatements();


