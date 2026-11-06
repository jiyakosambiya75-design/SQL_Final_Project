CREATE DATABASE IF NOT EXISTS final_project;

USE final_project;

-- Department Table
CREATE TABLE departments(
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

SELECT * FROM departments;


-- Students Table
CREATE TABLE students(
    Student_ID INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Email VARCHAR(100),
    Birth_Date DATE,
    Enrollment_Date DATE
);

INSERT INTO students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

SELECT * FROM students;


-- Courses Table
CREATE TABLE courses(
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50),
    Department_ID INT,
    Credits INT,
    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);

INSERT INTO courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

SELECT * FROM courses;


-- nstructor Table
CREATE TABLE instructors(
    Instructor_ID INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Email VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);

INSERT INTO instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 50000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 45000);

SELECT * FROM instructors;


--  Enrollments Table
CREATE TABLE enrollments(
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    FOREIGN KEY (Student_ID)
    REFERENCES students(Student_ID),
    FOREIGN KEY (Course_ID)
    REFERENCES courses(Course_ID)
);

INSERT INTO enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

SELECT * FROM enrollments;


-- 1. CRUD OPERATIONS

INSERT INTO students VALUES
(3, 'Alice', 'Both', 'alice.both@email.com',
'2000-01-08', '2021-08-05');

UPDATE departments
SET Department_Name = 'AI/ML'
WHERE Department_ID = 1;

DELETE FROM students
WHERE Student_ID = 3;


-- 2. Students enrolled after 2022

SELECT * FROM students
WHERE Enrollment_Date > '2021-12-31';


-- 3. Courses offered by Mathematics Department

SELECT *
FROM courses AS c
INNER JOIN departments AS d
ON d.Department_ID = c.Department_ID
WHERE d.Department_Name = 'Mathematics'
LIMIT 5;


-- 4. Students in each course (more than 5)

SELECT c.Course_Name,
COUNT(e.Student_ID) AS Total_Students
FROM courses AS c
INNER JOIN enrollments AS e
ON c.Course_ID = e.Course_ID
GROUP BY c.Course_Name
HAVING COUNT(e.Student_ID) > 5;


-- 5. Students enrolled in BOTH courses

SELECT s.Student_ID,
CONCAT(s.First_name, ' ', s.Last_name) AS Student_Name
FROM students s
INNER JOIN enrollments e1
ON s.Student_ID = e1.Student_ID
INNER JOIN courses c1
ON e1.Course_ID = c1.Course_ID
INNER JOIN enrollments e2
ON s.Student_ID = e2.Student_ID
INNER JOIN courses c2
ON e2.Course_ID = c2.Course_ID
WHERE c1.Course_Name = 'Introduction to SQL'
AND c2.Course_Name = 'Data Structures';


-- 6. Students enrolled in EITHER course

SELECT DISTINCT s.Student_ID,
CONCAT(s.First_name, ' ', s.Last_name) AS Student_Name
FROM students s
INNER JOIN enrollments e
ON s.Student_ID = e.Student_ID
INNER JOIN courses c
ON e.Course_ID = c.Course_ID
WHERE c.Course_Name IN ('Introduction to SQL', 'Data Structures');


-- 7. Average credits

SELECT AVG(Credits) AS Average_Credits
FROM courses;


-- 8. Maximum instructor salary

SELECT MAX(i.Salary) AS Maximum_Salary
FROM instructors i
INNER JOIN departments d
ON i.Department_ID = d.Department_ID
WHERE d.Department_Name = 'Computer Science';


-- 9. Students enrolled in each department

SELECT d.Department_Name,
COUNT(DISTINCT e.Student_ID) AS Total_Students
FROM departments d
LEFT JOIN courses c
ON d.Department_ID = c.Department_ID
LEFT JOIN enrollments e
ON c.Course_ID = e.Course_ID
GROUP BY d.Department_ID, d.Department_Name;


-- 10. INNER JOIN

SELECT s.Student_ID,
CONCAT(s.First_name, ' ', s.Last_name) AS Student_Name,
c.Course_Name
FROM students s
INNER JOIN enrollments e
ON s.Student_ID = e.Student_ID
INNER JOIN courses c
ON e.Course_ID = c.Course_ID;


-- 11. LEFT JOIN

SELECT s.Student_ID,
CONCAT(s.First_name, ' ', s.Last_name) AS Student_Name,
c.Course_Name
FROM students s
LEFT JOIN enrollments e
ON s.Student_ID = e.Student_ID
LEFT JOIN courses c
ON e.Course_ID = c.Course_ID;


-- 12. SUBQUERY

SELECT Student_ID,
CONCAT(First_name, ' ', Last_name) AS Student_Name
FROM students
WHERE Student_ID IN (SELECT Student_ID
FROM enrollments
WHERE Course_ID IN (SELECT Course_ID
FROM enrollments GROUP BY Course_ID
HAVING COUNT(Student_ID) > 10
    )
);


-- 13. Extract Year

SELECT Student_ID,
YEAR(Enrollment_Date) AS Enrollment_Year
FROM students;


-- 14. CONCAT Instructor Name

SELECT Instructor_ID,
CONCAT(First_name, ' ', Last_name) AS Full_Name
FROM instructors;


-- 15. Running Total

SELECT Enrollment_ID,
Student_ID,
Course_ID,
COUNT(*) OVER (ORDER BY Enrollment_ID
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total
FROM enrollments;


-- 16. Senior or Junior

SELECT Student_ID,
CONCAT(First_name, ' ', Last_name) AS Student_Name,
Enrollment_Date,
CASE
    WHEN Enrollment_Date < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS Student_Status
FROM students;
