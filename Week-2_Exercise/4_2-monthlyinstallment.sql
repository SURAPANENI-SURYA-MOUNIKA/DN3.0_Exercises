use control_structures;

DELIMITER //

CREATE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount DECIMAL(15, 2),
    p_annual_interest_rate DECIMAL(7, 4),
    p_loan_duration_years INT
) 
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE r DECIMAL(10, 8); 
    DECLARE n INT;           
    DECLARE emi DECIMAL(15, 2); 

    SET r = p_annual_interest_rate / 100 / 12;

    SET n = p_loan_duration_years * 12;

    IF r = 0 THEN
        SET emi = p_loan_amount / n;
    ELSE
        SET emi = (p_loan_amount * r * POW(1 + r, n)) / (POW(1 + r, n) - 1);
    END IF;

    RETURN emi;
END //

DELIMITER ;



SELECT CalculateMonthlyInstallment(10000, 5.0, 2) AS MonthlyInstallment;
