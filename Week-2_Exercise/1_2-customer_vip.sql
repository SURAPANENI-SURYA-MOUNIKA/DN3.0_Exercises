use control_structures;

ALTER TABLE customers
ADD balance DECIMAL(10, 2),
ADD IsVIP BOOLEAN DEFAULT FALSE;

UPDATE customers SET balance = 15000 WHERE customer_id = 301;
UPDATE customers SET balance = 8000 WHERE customer_id = 302;
UPDATE customers SET balance = 20000 WHERE customer_id = 303;
UPDATE customers SET balance = 9500 WHERE customer_id = 304;

COMMIT;

DELIMITER //

CREATE PROCEDURE PromoteToVIP()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_customer_id INT;
    DECLARE v_balance DECIMAL(10, 2);
    DECLARE cur CURSOR FOR 
        SELECT customer_id, balance
        FROM customers
        FOR UPDATE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_customer_id, v_balance;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF v_balance > 10000 THEN
            UPDATE customers
            SET IsVIP = TRUE
            WHERE customer_id = v_customer_id;
        END IF;
    END LOOP;

    CLOSE cur;

    COMMIT;
END //

DELIMITER ;

SELECT * FROM customers;
CALL PromoteToVIP();
SELECT * FROM customers;
