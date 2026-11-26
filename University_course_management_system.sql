--FINAL PROJECT – UNIVERSITY MANAGEMENT SYSTEM

-- ==========================================
-- DATABASE CREATION
-- ==========================================

CREATE DATABASE IF NOT EXISTS final_project;

USE final_project;

-- ==========================================
-- DROP EXISTING TABLES
-- ==========================================

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;


-- ==========================================
-- 1. DEPARTMENTS TABLE
-- ==========================================

CREATE TABLE departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

SELECT * FROM departments;


-- ==========================================
-- 2. STUDENTS TABLE
-- ==========================================

CREATE TABLE students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);

INSERT INTO students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

SELECT * FROM students;


-- ==========================================
-- 3. COURSES TABLE
-- ==========================================

CREATE TABLE courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID)
    REFERENCES departments(DepartmentID)
);

INSERT INTO courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

SELECT * FROM courses;


-- ==========================================
-- 4. INSTRUCTORS TABLE
-- ==========================================

CREATE TABLE instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID)
    REFERENCES departments(DepartmentID)
);

INSERT INTO instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 50000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 45000);

SELECT * FROM instructors;


-- ==========================================
-- 5. ENROLLMENTS TABLE
-- ==========================================

CREATE TABLE enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID)
    REFERENCES students(StudentID),
    FOREIGN KEY (CourseID)
    REFERENCES courses(CourseID)
);

INSERT INTO enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

SELECT * FROM enrollments;


-- ==========================================
-- CRUD OPERATIONS
-- ==========================================

-- CREATE / INSERT

INSERT INTO students VALUES
(3, 'Alice', 'Both', 'alice.both@email.com',
 '2000-01-08', '2021-08-05');

-- UPDATE

UPDATE departments
SET DepartmentName = 'AI/ML'
WHERE DepartmentID = 1;

-- DELETE

DELETE FROM students
WHERE StudentID = 3;


-- ==========================================
-- TASK 1: Students enrolled after 2022
-- ==========================================

SELECT *
FROM students
WHERE EnrollmentDate >= '2023-01-01';


-- ==========================================
-- TASK 2: Courses offered by Mathematics
-- ==========================================

SELECT *
FROM courses
WHERE DepartmentID = (
    SELECT DepartmentID
    FROM departments
    WHERE DepartmentName = 'Mathematics'
);


-- ==========================================
-- TASK 3: Number of students in each course
-- ==========================================

SELECT
    c.CourseName,
    COUNT(e.StudentID) AS TotalStudents
FROM courses c
LEFT JOIN enrollments e
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) >= 1;


-- ==========================================
-- TASK 4: Students enrolled in both courses
-- ==========================================

SELECT StudentID
FROM enrollments
WHERE CourseID = 101
AND StudentID IN (
    SELECT StudentID
    FROM enrollments
    WHERE CourseID = 102
);


-- ==========================================
-- TASK 5: Students enrolled in either course
-- ==========================================

SELECT DISTINCT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName
FROM students s
INNER JOIN enrollments e
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN (
    'Introduction to SQL',
    'Data Structures'
);


-- ==========================================
-- TASK 6: Average course credits
-- ==========================================

SELECT AVG(Credits) AS AverageCredits
FROM courses;


-- ==========================================
-- TASK 7: Maximum instructor salary
-- ==========================================

SELECT MAX(i.Salary) AS MaximumSalary
FROM instructors i
INNER JOIN departments d
ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- ==========================================
-- TASK 8: Students in each department
-- ==========================================

SELECT
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM departments d
LEFT JOIN courses c
ON d.DepartmentID = c.DepartmentID
LEFT JOIN enrollments e
ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;


-- ==========================================
-- TASK 9: INNER JOIN
-- ==========================================

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM students s
INNER JOIN enrollments e
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID;


-- ==========================================
-- TASK 10: LEFT JOIN
-- ==========================================

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM students s
LEFT JOIN enrollments e
ON s.StudentID = e.StudentID
LEFT JOIN courses c
ON e.CourseID = c.CourseID;


-- ==========================================
-- TASK 11: SUBQUERY
-- Students enrolled in courses having
-- more than 10 students
-- ==========================================

SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS StudentName
FROM students
WHERE StudentID IN (
    SELECT StudentID
    FROM enrollments
    WHERE CourseID IN (
        SELECT CourseID
        FROM enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);


-- ==========================================
-- TASK 12: Extract enrollment year
-- ==========================================

SELECT
    StudentID,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM students;


-- ==========================================
-- TASK 13: Concatenate instructor name
-- ==========================================

SELECT
    InstructorID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM instructors;


-- ==========================================
-- TASK 14: Running total of students
-- ==========================================

SELECT
    EnrollmentID,
    StudentID,
    CourseID,
    COUNT(StudentID) OVER (
        ORDER BY EnrollmentID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalStudents
FROM enrollments;


-- ==========================================
-- TASK 15: Senior or Junior students
-- ==========================================

SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS StudentName,
    EnrollmentDate,
    CASE
        WHEN EnrollmentDate < DATE_SUB(
            CURDATE(), INTERVAL 4 YEAR
        )
        THEN 'Senior'
        ELSE 'Junior'
    END AS StudentStatus
FROM students;


-- ==========================================
-- FINAL PROJECT COMPLETED
-- ==========================================

-- Display all tables

SHOW TABLES;
