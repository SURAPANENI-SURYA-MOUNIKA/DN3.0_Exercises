use control_structures;

DELIMITER //

CREATE FUNCTION HasSufficientBalance(
    p_account_id INT,
    p_amount DECIMAL(15, 2)
) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_balance DECIMAL(15, 2);
    DECLARE sufficient_balance BOOLEAN;

    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id;

    IF v_balance IS NULL THEN
        RETURN FALSE;
    ELSE
        IF v_balance >= p_amount THEN
            SET sufficient_balance = TRUE;
        ELSE
            SET sufficient_balance = FALSE;
        END IF;
    END IF;

    RETURN sufficient_balance;
END //

DELIMITER ;



SELECT HasSufficientBalance(1, 1000.00) AS IsSufficient;
