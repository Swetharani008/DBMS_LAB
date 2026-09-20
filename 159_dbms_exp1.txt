use db;
Database changed
CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(30), Age INT);
CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(20));
CREATE TABLE Enrollments (StudentID INT REFERENCES Student(StudentID),CourseID INT REFERENCES Courses(CourseID));

INSERT INTO Students VALUES (1, 'Alice', 20);
INSERT INTO Students VALUES (2, 'Bob', 22);
INSERT INTO Students VALUES (3, 'Charlie', 21);
INSERT INTO Students VALUES (4, 'David', 19);

INSERT INTO Courses VALUES (101, 'Database Management');
INSERT INTO Courses VALUES (102, 'Algorithms');
INSERT INTO Courses VALUES (103, 'Web Development');

INSERT INTO Enrollments VALUES (1, 101);
INSERT INTO Enrollments VALUES (1, 102);
INSERT INTO Enrollments VALUES (2, 102);
INSERT INTO Enrollments VALUES (3, 101);
INSERT INTO Enrollments VALUES (3, 103);
INSERT INTO Enrollments VALUES (4, 103);

Select *from Students;
+-----------+---------+------+
| StudentID | Name    | Age  |
+-----------+---------+------+
|         1 | Alice   |   20 |
|         2 | Bob     |   22 |
|         3 | Charlie |   21 |
|         4 | David   |   19 |
+-----------+---------+------+
4 rows in set (0.00 sec)

Select *from Courses;
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      102 | Algorithms          |
|      103 | Web Development     |
+----------+---------------------+
3 rows in set (0.00 sec)

Select *from Enrollments;
+-----------+----------+
| StudentID | CourseID |
+-----------+----------+
|         1 |      101 |
|         1 |      102 |
|         2 |      102 |
|         3 |      101 |
|         3 |      103 |
|         4 |      103 |
+-----------+----------+
6 rows in set (0.00 sec)

SELECT Name, Age FROM Students WHERE Age > 20;
+---------+------+
| Name    | Age  |
+---------+------+
| Bob     |   22 |
| Charlie |   21 |
+---------+------+
2 rows in set (0.00 sec)

SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID = (
        SELECT CourseID
        FROM Courses
        WHERE CourseName = 'Database Management'
    )
);

+---------+
| Name    |
+---------+
| Alice   |
| Charlie |
+---------+
2 rows in set (0.00 sec)

SELECT AVG(Age) AS AverageAge FROM Students;
+------------+
| AverageAge |
+------------+
|    20.5000 |
+------------+
1 row in set (0.00 sec)

SELECT CourseID, CourseName
FROM Courses
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(*) > 1
);
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      102 | Algorithms          |
|      103 | Web Development     |
+----------+---------------------+
3 rows in set (0.00 sec)

SELECT Name, Age FROM Students
    -> WHERE Age > (SELECT AVG(Age) FROM Students);
+---------+------+
| Name    | Age  |
+---------+------+
| Bob     |   22 |
| Charlie |   21 |
+---------+------+
2 rows in set (0.00 sec)
