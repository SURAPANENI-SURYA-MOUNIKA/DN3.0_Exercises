use control_structures;


DESCRIBE Accounts;

DROP PROCEDURE IF EXISTS ApplyAnnualFee;
DELIMITER //

CREATE PROCEDURE ApplyAnnualFee()
BEGIN
    DECLARE v_account_id INT;
    DECLARE v_balance DECIMAL(15, 2);
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE v_annual_fee DECIMAL(15, 2) DEFAULT 50.00; 

    DECLARE cur_accounts CURSOR FOR
        SELECT account_id, balance
        FROM Accounts;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur_accounts;

    read_loop: LOOP
        FETCH cur_accounts INTO v_account_id, v_balance;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_balance = v_balance - v_annual_fee;

        UPDATE Accounts
        SET balance = v_balance
        WHERE account_id = v_account_id;
    END LOOP;

    CLOSE cur_accounts;

    COMMIT;
END //

DELIMITER ;


CALL ApplyAnnualFee();
SELECT * FROM Accounts;



