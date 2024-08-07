use control_structures;

DELIMITER //

CREATE PROCEDURE UpdateEmployeeBonus(
    IN p_department VARCHAR(50),
    IN p_bonus_percentage DECIMAL(5, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO error_log (error_message) VALUES (CONCAT('An error occurred while updating bonuses for department ', p_department));
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE employees
    SET salary = salary * (1 + p_bonus_percentage / 100)
    WHERE department = p_department;

    COMMIT;
END //

DELIMITER ;



CALL UpdateEmployeeBonus('Sales', 10.00);
SELECT * FROM employees;

