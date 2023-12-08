-- Lab 6 - Nov 28
/*
	Stored Procedures, Views, Triggers
*/

------------------------------------------------------------------------------------
-- Book return should insert an entry into the Book_Return table and also 
-- update the status in Book_Issue table as ‘Returned’. Create a database
-- TRANSACTION to do this operation (stored procedure).
------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE calcLateFee(IN dateDiff INT, OUT fine INT)
BEGIN
	IF (dateDiff <= 0) THEN
		set fine = 0;
	ELSEIF (dateDiff < 7) THEN
		SET fine = 10;
	ELSEIF (dateDiff < 30) THEN
		SET fine = 100;
	ELSE
		SET fine = ((dateDiff-30)*100);
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE bookReturn(IN issueId INT)
BEGIN
	DECLARE dateDifference INT;
	DECLARE lateFee INT;
	DECLARE returnDate DATE;
	
	SELECT (DATEDIFF(CURDATE(),expected_date_of_return)) 
	INTO @dateDifference
	FROM book_issue
	WHERE issue_id=issueId;
	
	CALL calcLateFee(@dateDifference, @lateFee);
	
	INSERT INTO book_return VALUES (issueId,CURDATE(),IF(@dateDifference>0,@dateDifference,0),@lateFee);
END $$
DELIMITER ;

------------------------------------------------------------------------------------
-- Create a database view ‘Available_Books’, which will list out books that 
-- are currently available in the library
------------------------------------------------------------------------------------
CREATE VIEW available_books AS
    SELECt title
    FROM book
    WHERE status="Available";


select * from available_books;
/*
+--------------+
| title        |
+--------------+
| LOTR         |
| Harry Potter |
+--------------+
*/

------------------------------------------------------------------------------------
-- Create a database procedure to add, update and delete a book to the 
-- Library database (use parameters).
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
-- Use cursors and create a procedure to print Books Issue Register 
-- (page wise – 20 rows in a page)
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Create a history table (you may use the same structure without any keys) 
-- for the MEMBER table and copy the original values of the row being updated
-- to the history table using a TRIGGER.
------------------------------------------------------------------------------------
