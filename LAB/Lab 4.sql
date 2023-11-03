-- Lab 4 - Nov 3
/*
Using bulk updates/deletes
*/
-----------------------------------------------------------------------------

Create and execute UPDATE/DELETE commands on tables. Try to update/delete
rows with Primary and Foreign Keys. Try bulk updates or deletes using SQL
UPDATE statement

-----------------------------------------------------------------------------

-- When we try to delete a row with foreign/primary key 
DELETE FROM book WHERE book_id=1;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key 
-- constraint fails (`library`.`book_author`, CONSTRAINT `book_author_ibfk_1`
-- FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`))


-- When we try to update a non key attribute
UPDATE book SET title="Harry Potter" WHERE book_id=1;
-- Query OK, 1 row affected (0.40 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

SELECT * FROM book WHERE book_id=1;
/*
+---------+--------------+--------+--------+------+----------------+---------+--------------+
| book_id | title        | volume | status | mrp  | published_date | lang_id | publisher_id |
+---------+--------------+--------+--------+------+----------------+---------+--------------+
|       1 | Harry Potter |      4 | lost   |  386 | 1958-03-19     |     465 |          598 |
+---------+--------------+--------+--------+------+----------------+---------+--------------+

*/

-- Performing bulk update
UPDATE book SET status="lost" WHERE title LIKE "a%";
-- Query OK, 64 rows affected (0.08 sec)
-- Rows matched: 100  Changed: 64  Warnings: 0

SELECT book_id, title, status FROM book WHERE title LIKE "a%";
/*
+---------+----------------------+--------+
| book_id | title                | status |
+---------+----------------------+--------+
|       2 | arcu sed augue aliqu | lost   |
|       4 | aliquet massa id lob | lost   |
|       5 | ac lobortis vel dapi | lost   |
|      14 | amet                 | lost   |
                 ...
                 ...
                 ...
|     988 | a libero nam dui     | lost   |
|     990 | aliquet massa id lob | lost   |
|     992 | amet                 | lost   |
+---------+----------------------+--------+
*/

