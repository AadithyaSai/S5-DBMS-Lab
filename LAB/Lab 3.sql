-- Lab 3 - Oct 27
/*
Using GRANT/REVOKE and bulk INSERTs with LOAD INFILE
*/
-----------------------------------------------------------------------------

-- Create and execute GRANT/REVOKE commands on tables.

-----------------------------------------------------------------------------

-- Creating a new user
CREATE USER 'newuser'@'localhost' IDENTIFIED BY "Password@1";
--Query OK, 0 rows affected (0.11 sec)

-- Switch to new user and try any command
SYSTEM mysql -u newuser -p
USE library
-- ERROR 1044 (42000): Access denied for user 'newuser'@'localhost' to database 'library'

-- Now to grant all privileges to newuser, switch back to root user (batch here)
SYSTEM mysql -u batch -p
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'localhost';
-- Query OK, 0 rows affected (0.26 sec)

-- Now we switch back to newuser and try again
SYSTEM mysql -u newuser -p
USE library
/*
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

*/

-- We now switch back to batch and drop the user
DROP USER 'newuser'@'localhost';
-- Query OK, 0 rows affected (0.25 sec)

-----------------------------------------------------------------------------

-- Learn and execute bulk import of data to tables from CSV files (insert 1000
-- records ofbooks into the BOOK table from a CSV file) Create and execute SQL
-- commands to insert data into each of the tables designed

-----------------------------------------------------------------------------

/*
Use Mockaroo website to generate 1000 dummy records for the book table
The data is stored in Downloads/ folder as mock_book.csv
*/

-- to enable LOAD INFILE to use local files, we set the global property local_infile to 1
SET GLOBAL local_infile=1;

-- For convenience we disable foreign_key_checks to avoid foreign key failures
SET foreign_key_checks=0;

-- Now we load the data
LOAD DATA LOCAL INFILE '~/Downloads/mock_book.csv' INTO TABLE book FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT * FROM book;
/*
+---------+----------------------+--------+-----------+------+----------------+---------+--------------+
| book_id | title                | volume | status    | mrp  | published_date | lang_id | publisher_id |
+---------+----------------------+--------+-----------+------+----------------+---------+--------------+
|       1 | sapien sapien non mi |      4 | lost      |  386 | 1958-03-19     |     465 |          598 |
|       2 | arcu sed augue aliqu |      8 | available |  256 | 2013-11-07     |     178 |          378 |
|       3 | ipsum ac tellus semp |      4 | lost      |  485 | 1907-03-08     |     259 |          591 |
|       4 | aliquet massa id lob |      1 | available |  784 | 2009-05-04     |     848 |          835 |
                                                ...
                                                ...
                                                ...
                                                ...
|     999 | luctus tincidunt nul |      6 | borrowed  |  231 | 2001-11-18     |      65 |          829 |
|    1000 | in quam fringilla rh |      6 | borrowed  |  997 | 1967-03-21     |     238 |          767 |
+---------+----------------------+--------+-----------+------+----------------+---------+--------------+
*/
