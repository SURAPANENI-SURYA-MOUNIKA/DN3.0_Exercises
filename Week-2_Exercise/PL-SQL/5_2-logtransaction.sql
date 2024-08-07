use control_structures;

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATETIME,
    amount DECIMAL(15, 2)
);

CREATE TABLE AuditLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    transaction_date DATETIME,
    action VARCHAR(50),
    old_value DECIMAL(15, 2),
    new_value DECIMAL(15, 2),
    log_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);



DELIMITER //

CREATE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (transaction_id, transaction_date, action, old_value, new_value)
    VALUES (NEW.transaction_id, NEW.transaction_date, 'INSERT', NULL, NEW.amount);
END //

DELIMITER ;




INSERT INTO Transactions (transaction_date, amount)
VALUES (NOW(), 500.00);

SELECT * FROM AuditLog;
