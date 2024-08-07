use control_structures;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, employee_name, salary) VALUES 
(1, 'John Doe', 50000.00),
(2, 'Jane Smith', 60000.00),
(3, 'Sam Brown', 55000.00);

COMMIT;

DELIMITER //

CREATE PROCEDURE UpdateSalary(
    IN p_employee_id INT,
    IN p_percentage DECIMAL(5, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO error_log (error_message) VALUES (CONCAT('An error occurred while updating salary for employee ID ', p_employee_id));
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT * FROM employees WHERE employee_id = p_employee_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID does not exist';
    END IF;

    UPDATE employees
    SET salary = salary + (salary * (p_percentage / 100))
    WHERE employee_id = p_employee_id;

    COMMIT;
END //

DELIMITER ;





CREATE TABLE error_log1 (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_message VARCHAR(255),
    error_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CALL UpdateSalary(1, 10.00);
SELECT * FROM employees;



CALL UpdateSalary(4, 10.00);
SELECT * FROM employees;
SELECT * FROM error_log1;



