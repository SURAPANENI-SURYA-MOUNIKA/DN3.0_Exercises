use control_structures;

ALTER TABLE customers
ADD date_of_birth DATE;

UPDATE customers
SET date_of_birth = '1959-08-15' -- for customer_id = 301
WHERE customer_id = 301;

UPDATE customers
SET date_of_birth = '1979-06-22' -- for customer_id = 302
WHERE customer_id = 302;

UPDATE customers
SET date_of_birth = '1954-11-30' -- for customer_id = 303
WHERE customer_id = 303;

UPDATE customers
SET date_of_birth = '1962-05-10' -- for customer_id = 3044
WHERE customer_id = 3044;




DELIMITER //

CREATE FUNCTION CalculateAge(dob DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    DECLARE today DATE;

    SET today = CURDATE();

    SET age = TIMESTAMPDIFF(YEAR, dob, today);

    RETURN age;
END //

DELIMITER ;




SELECT CalculateAge('1959-08-15') AS Age;


SELECT customer_id, name, date_of_birth, CalculateAge(date_of_birth) AS age
FROM customers;
