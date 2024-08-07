use control_structures;
DROP PROCEDURE IF EXISTS HireEmployee;
DROP FUNCTION IF EXISTS HireEmployee;

DELIMITER //

CREATE PROCEDURE HireEmployee(
    IN p_employee_id INT,
    IN p_name VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(15, 2)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE employee_id = p_employee_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID already exists';
    ELSE
        INSERT INTO Employees (employee_id, name, position, salary)
        VALUES (p_employee_id, p_name, p_position, p_salary);
    END IF;
END //

DELIMITER ;




DELIMITER //

CREATE PROCEDURE UpdateEmployee(
    IN p_employee_id INT,
    IN p_name VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(15, 2)
)
BEGIN
    UPDATE Employees
    SET name = p_name,
        position = p_position,
        salary = p_salary
    WHERE employee_id = p_employee_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID does not exist';
    END IF;
END //

DELIMITER ;





DELIMITER //

CREATE FUNCTION CalculateAnnualSalary(
    p_employee_id INT
) RETURNS DECIMAL(15, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_salary DECIMAL(15, 2);

    SELECT salary INTO v_salary
    FROM Employees
    WHERE employee_id = p_employee_id;

    IF v_salary IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID does not exist';
    END IF;

    RETURN v_salary * 12;
END //

DELIMITER ;


SELECT CalculateAnnualSalary(1);
