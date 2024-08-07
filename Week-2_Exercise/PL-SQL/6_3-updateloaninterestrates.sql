use control_structures;



CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    interest_rate DECIMAL(5, 2),
    loan_amount DECIMAL(15, 2),
    loan_duration INT 
);


INSERT INTO Loans (loan_id, interest_rate, loan_amount, loan_duration) VALUES
(1, 5.00, 10000.00, 24),
(2, 4.50, 20000.00, 36),
(3, 6.00, 15000.00, 12);

DROP PROCEDURE IF EXISTS UpdateLoanInterestRates;


DELIMITER //

CREATE PROCEDURE UpdateLoanInterestRates()
BEGIN
    DECLARE v_loan_id INT;
    DECLARE v_current_interest_rate DECIMAL(5, 2);
    DECLARE v_new_interest_rate DECIMAL(5, 2);
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE v_increase_percentage DECIMAL(5, 2) DEFAULT 0.50; 

    DECLARE cur_loans CURSOR FOR
        SELECT loan_id, interest_rate
        FROM Loans;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur_loans;
    
    read_loop: LOOP
        FETCH cur_loans INTO v_loan_id, v_current_interest_rate;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_new_interest_rate = v_current_interest_rate + v_increase_percentage;

        UPDATE Loans
        SET interest_rate = v_new_interest_rate
        WHERE loan_id = v_loan_id;
    END LOOP;

    CLOSE cur_loans;

    COMMIT;
END //

DELIMITER ;


CALL UpdateLoanInterestRates();
select *from Loans;