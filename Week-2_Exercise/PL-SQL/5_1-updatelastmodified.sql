use control_structures;


ALTER TABLE customers
ADD LastModified DATETIME;


DELIMITER //

CREATE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    SET NEW.LastModified = NOW();
END //

DELIMITER ;





UPDATE customers
SET name = 'New Name'
WHERE customer_id = 301;

SELECT customer_id, name, LastModified
FROM customers
WHERE customer_id = 301;



