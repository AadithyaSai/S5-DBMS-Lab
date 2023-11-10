-- Lab 5 - Nov 10
/*
Write SQLQuery to retrieve the following information
*/
-----------------------------------------------------------------------------

-- a. Get the number of books written by a given author

-----------------------------------------------------------------------------

SELECT a.name, count(*) AS books FROM book_author AS ba, author AS a WHERE a.author_id=ba.author_id GROUP BY ba.author_id;

/*
+------------+-------+
| name       | books |
+------------+-------+
| JK Rowling |     1 |
| Tolkien    |     2 |
| John Doe   |     1 |
| Jane Doe   |     1 |
+------------+-------+
*/

-----------------------------------------------------------------------------

-- b. Get the list of publishers and the number of books published by each 
--    publisher

-----------------------------------------------------------------------------

SELECT pub.name, count(*) AS books FROM publisher as pub, book WHERE pub.publisher_id=book.publisher_id GROUP BY pub.publisher_id;

/*
+---------+----------+
| name    | books    |
+---------+----------+
| H&C     |        1 |
| M&N     |        1 |
| penguin |        2 |
+---------+----------+
*/

-----------------------------------------------------------------------------

-- c. Get the names of authors who jointly wrote more than one book.

-----------------------------------------------------------------------------

SELECT a1.name 
FROM author AS a1, author AS a2, book_author AS ba1, book_author AS ba2  
WHERE a1.author_id != a2.author_id AND ba1.book_id = ba2.book_id AND a1.author_id = ba1.author_id AND a2.author_id = ba2.author_id 
GROUP BY a1.author_id 
HAVING COUNT(*) >= 2;

/*
+----------+
| name     |
+----------+
| John Doe |
| Jane Doe |
+----------+
*/

-----------------------------------------------------------------------------

-- d. Get the list of books that are issued but not returned

-----------------------------------------------------------------------------

SELECT COUNT(*) AS "BOOKS NOT RETURNED" FROM book_issue AS bi, book_return AS br WHERE br.issue_id = bi.issue_id AND CURDATE() < br.actual_date_of_return;

/*
+--------------------+
| BOOKS NOT RETURNED |
+--------------------+
|                  1 |
+--------------------+
*/

-----------------------------------------------------------------------------

-- e. Get the list of students who reads only ‘Malayalam’ books

-----------------------------------------------------------------------------

SELECT m.name
FROM member AS m, book_issue AS bi, book AS b, language AS l
WHERE m.member_id=bi.member_id AND bi.book_id=b.book_id AND b.lang_id=l.lang_id AND l.name="Malayalam";

/*
+-------+
| name  |
+-------+
| hena  |
| helos |
| lelos |
*/

-----------------------------------------------------------------------------

-- f. Get the total fine collected for the current month and current quarter

-----------------------------------------------------------------------------

SELECT SUM(month.fine) AS MONTHLY, SUM(qtr.fine) AS QUARTERLY
FROM (
		SELECT late_fee AS fine
		FROM book_return
		WHERE MONTH(actual_date_of_return) = MONTH(CURDATE()) AND YEAR(actual_date_of_return) = YEAR(CURDATE())
	) AS month, (
		SELECT late_fee AS fine
		FROM book_return
		WHERE QUARTER(actual_date_of_return)=QUARTER(CURDATE()) AND YEAR(actual_date_of_return) = YEAR(CURDATE())
	) as qtr;

/*
+---------+-----------+
| MONTHLY | QUARTERLY |
+---------+-----------+
|     500 |       840 |
+---------+-----------+
*/

-----------------------------------------------------------------------------

-- g. Get the list of students who have overdue (not returned the books 
--    even on due date)

-----------------------------------------------------------------------------

SELECT member.name AS "OVERDUE LIST"
FROM member
    JOIN book_issue ON book_issue.member_id=member.member_id
    JOIN book_return ON book_issue.issue_id=book_return.issue_id
WHERE expected_date_of_return < actual_date_of_return;

/*
+--------------+
| OVERDUE LIST |
+--------------+
| Maria        |
| Mahima       |
| hena         |
| helos        |
| lelos        |
+--------------+
*/

-----------------------------------------------------------------------------

-- h. Calculate the fine (as of today) to be collected from each overdue book.

-----------------------------------------------------------------------------

-- TODO: Incomplete!

-----------------------------------------------------------------------------

-- i. Members who joined after Jan 1 2021 but has not taken any books

-----------------------------------------------------------------------------

SELECT name
FROM member
WHERE member.date_of_join > "2021-01-01" AND member.member_id NOT IN (
    SELECT member_id
    FROM book_issue
);

/*
+------+
| name |
+------+
| John |
+------+
*/
