use db;
Database changed
-----------Table creation------------

CREATE TABLE students (student_id SERIAL PRIMARY KEY,student_name VARCHAR(100),student_email VARCHAR(100));

-----------Table creation------------

INSERT INTO students (student_name, student_email) VALUES ('Alice Johnson', 'alice@example.com');
INSERT INTO students (student_name, student_email) VALUES ('Bob Smith', 'bob@example.com');
INSERT INTO students (student_name, student_email) VALUES ('Charlie Brown', 'charlie@example.com');

----------Create a view---------------

CREATE VIEW student_view AS
    -> SELECT student_id, student_name, student_email FROM students;

----------DML operations--------------

INSERT INTO students (student_name, student_email) VALUES ('Diana Prince', 'diana@example.com');



UPDATE students SET student_email = 'new_bob@example.com' WHERE student_name = 'Bob Smith';

Rows matched: 1  Changed: 1  Warnings: 0


DELETE FROM students WHERE student_name = 'Charlie Brown';

------------View Table--------------

SELECT * FROM student_view;
+------------+---------------+---------------------+
| student_id | student_name  | student_email       |
+------------+---------------+---------------------+
|          1 | Alice Johnson | alice@example.com   |
|          2 | Bob Smith     | new_bob@example.com |
|          4 | Diana Prince  | diana@example.com   |
+------------+---------------+---------------------+
3 rows in set (0.00 sec)

-----------Index Creation--------------

CREATE INDEX idx_student_email ON students (student_email);

Records: 0  Duplicates: 0  Warnings: 0

SHOW INDEX FROM students;
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name          | Seq_in_index | Column_name   | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY           |            1 | student_id    | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          0 | student_id        |            1 | student_id    | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_student_email |            1 | student_email | A         |           3 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.03 sec)

