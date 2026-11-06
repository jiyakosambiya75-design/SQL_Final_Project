CREATE DATABASE IF NOT EXISTS final_project;

USE final_project;

-- 5. Departments Table
CREATE TABLE departments(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

SELECT * FROM departments;


-- 1. Students Table
CREATE TABLE students(
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


-- 2. Courses Table
CREATE TABLE courses(
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


-- 3. Instructors Table
CREATE TABLE instructors(
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


-- 4. Enrollments Table
CREATE TABLE enrollments(
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


---====================================================

-- 1. Perform CRUD Operations on all tables.

-- [C]reate / Insert
INSERT INTO students VALUES 
(3, 'Alice', 'Both', 'alice.both@email.com', '2000-01-08', '2021-08-05');

-- [U]pdate
UPDATE departments 
SET DepartmentName = 'AI/ML' 
WHERE DepartmentID = 1;

-- [D]elete
DELETE FROM students 
WHERE StudentID = 3;

-- 2. Retrieve students who enrolled after 2022.
SELECT * FROM students 
WHERE EnrollmentDate > '2022-12-31';


-- 3. Retrieve courses offered by the Mathematics department with a limit of 5 courses.
SELECT c.* 
FROM courses AS c
INNER JOIN departments AS d 
ON d.DepartmentID = c.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;


-- 4. Get the number of students enrolled in each course, filtering for courses with more than 5 students.
SELECT c.CourseName, 
COUNT(e.StudentID) AS TotalStudents
FROM courses AS c
INNER JOIN enrollments AS e 
ON c.CourseID = e.CourseID GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5;


-- 5. Find students who are enrolled in both Introduction to SQL and Data Structures.
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName
FROM students s
INNER JOIN enrollments e1 
ON s.StudentID = e1.StudentID
INNER JOIN courses c1 
ON e1.CourseID = c1.CourseID
INNER JOIN enrollments e2
ON s.StudentID = e2.StudentID
INNER JOIN courses c2 
ON e2.CourseID = c2.CourseID
WHERE c1.CourseName = 'Introduction to SQL' AND c2.CourseName = 'Data Structures';


-- 6. Find students who are either enrolled in Introduction to SQL or Data Structures.
SELECT DISTINCT s.StudentID, 
CONCAT(s.FirstName, ' ', s.LastName) AS StudentName
FROM students s
INNER JOIN enrollments e 
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');


-- 7. Calculate the average number of credits for all courses.
SELECT AVG(Credits) AS AverageCredits
FROM courses;


-- 8. Find the maximum salary of instructors in the Computer Science department.
SELECT MAX(i.Salary) AS MaximumSalary
FROM instructors i
INNER JOIN departments d
ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- 9. Count the number of students enrolled in each department.
SELECT d.DepartmentName, 
COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM departments d
LEFT JOIN courses c 
ON d.DepartmentID = c.DepartmentID
LEFT JOIN enrollments e 
ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;


-- 10. INNER JOIN: Retrieve students and their corresponding courses.
SELECT s.StudentID,
CONCAT(s.FirstName, ' ', s.LastName) AS StudentName, c.CourseName
FROM students s
INNER JOIN enrollments e 
ON s.StudentID = e.StudentID
INNER JOIN courses c 
ON e.CourseID = c.CourseID;


-- 11. LEFT JOIN: Retrieve all students and their corresponding courses, if any.
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName, c.CourseName
FROM students s
LEFT JOIN enrollments e 
ON s.StudentID = e.StudentID
LEFT JOIN courses c 
ON e.CourseID = c.CourseID;


-- 12. Subquery: Find students enrolled in courses that have more than 10 students.
SELECT StudentID, 
CONCAT(FirstName, ' ', LastName) AS StudentName
FROM students
WHERE StudentID IN (SELECT StudentID 
FROM enrollments 
WHERE CourseID IN (SELECT CourseID 
        FROM enrollments 
        GROUP BY CourseID 
        HAVING COUNT(StudentID) > 10)
);


-- 13. Extract the year from the EnrollmentDate of students.
SELECT StudentID,
YEAR(EnrollmentDate) AS EnrollmentYear 
FROM students;


-- 14. Concatenate the instructor's first and last name.
SELECT InstructorID, CONCAT(FirstName, ' ', LastName) AS FullName
FROM instructors;


-- 15. Calculate the running total of students enrolled in courses.
SELECT EnrollmentID, 
StudentID,
CourseID,
COUNT(StudentID) OVER (ORDER BY EnrollmentID) AS RunningTotalStudents
FROM enrollments;


-- 16. Label students as 'Senior' or 'Junior' based on their year of enrollment.
SELECT StudentID,
CONCAT(FirstName, ' ', LastName) AS StudentName, EnrollmentDate,
CASE
    WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
    ELSE 'Junior'
END AS StudentStatus
FROM students;
