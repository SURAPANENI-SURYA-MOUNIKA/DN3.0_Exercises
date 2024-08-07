use control_structures;

ALTER TABLE customers
ADD loan_due_date DATE;

UPDATE customers SET loan_due_date = '2024-08-20' WHERE customer_id = 301;
UPDATE customers SET loan_due_date = '2024-09-01' WHERE customer_id = 302;
UPDATE customers SET loan_due_date = '2024-08-10' WHERE customer_id = 303;
UPDATE customers SET loan_due_date = '2024-07-25' WHERE customer_id = 304;

COMMIT;

DELIMITER //

CREATE PROCEDURE SendLoanReminders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_customer_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_loan_due_date DATE;
    DECLARE cur CURSOR FOR 
        SELECT customer_id, name, loan_due_date
        FROM customers
        WHERE loan_due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_customer_id, v_name, v_loan_due_date;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT CONCAT('Reminder: Dear ', v_name, ', your loan is due on ', v_loan_due_date) AS reminder_message;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;


CALL SendLoanReminders();

