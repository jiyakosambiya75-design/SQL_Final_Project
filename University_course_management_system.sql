CREATE DATABASE final_project;

USE final_project;

---Department_table 
CREATE TABLE departments(
Department_ID INT PRIMARY KEY,
Department_Name VARCHAR(50)

DESC departments;

INSERT INTO departments VALUES
(1 , "Computer Science"),
(2 , "Mathematics");

SELECT * FROM departments ;

---student_table
CREATE TABLE students (
Student_ID INT PRIMARY KEY ,
First_name VARCHAR(50),
Last_name VARCHAR(50),
Email VARCHAR(100),
Birth_Date DATE ,
Enrollment_Date DATE);

DESC students ;

INSERT INTO students VALUES 
(1 , "John" , "Doe" , "john.doe@email.com" , "2000-01-15" , "2022-08-01"),
(2 , "Jane" , "Smith" , "jane.smith@email.com" , "1999-05-25" , "2021-08-01");

SELECT * FROM students;

---course_table
CREATE TABLE courses (
Course_ID INT PRIMARY KEY , 
Course_Name VARCHAR(50) , 
Department_ID VARCHAR(50), 
Credits INT
FOREIGN KEY Department_ID
REFERENCES departments(Department_ID);

DESC courses;

INSERT INTO courses VALUES 
(101 , "Introduction to SQL" , 1 , 3),
(102 , "Data Sturcture" , 2 , 4);

SELECT * FROM courses ;

---Instructor_table
CREATE TABLE instructor(
Instructor_ID INT PRIMARY KEY ,
First_name VARCHAR(50),
Last_name VARCHAR(50),
Email VARCHAR(100),
Department_ID INT,
FOREIGN KEY (Department_ID)
REFERENCES departments(Department_ID));

DESC instructor;

INSERT INTO instructor VALUES
(1 , "Alice" , "Johnson" , "alice.johnson@univ.com" , 1),
(2 , "Bob" , "Lee" , "bob.lee.@univ.com" , 2);

SELECT * FROM instructor;

---Enrollments_table 
CREATE TABLE enrollments(
Enrollment_ID INT PRIMARY KEY,
Student_ID INT ,
Course_ID INT ,
Enrollment_Date DATE ,
FOREIGN KEY (Student_ID)
REFERENCES students(Student_ID),
FOREIGN KEY (Course_ID)
REFERENCES courses(Course_ID),
FOREIGN KEY (Enrollment_Date)
REFERENCES enrollments(Enrollment_Date));

DESC enrollments;

INSERT INTO enrollments VALUES
(1 , 1 , 101 , "2022-08-01"),
(2 , 2 , 102 , "2021-08-01");

SELECT * FROM enrollments;

--- QUERIES TO PERFORM

-- - 1.CRUD OPERATION 
INSERT INTO students VALUE
(3 , "Alice" , "Both" , "alice.both@email.com" , "2000-01-08" , "2021-08-05");

UPDATE departments
SET Department_Name = AI/ML 
WHERE Department_ID = 1 ;

DELETE students
WHERE Student_ID = 3;

-- 2.Retrieve students who enrolled after 2022.
SELECT * FROM students
WHERE Enrollment_Date > 2021-12-31 ;

-- 3. Retrieve courses offered by the Mathematics department with a limit of 5 courses.
SELECT * FROM courses AS c
INNER JOIN Departments AS d
On d.Department_ID = c.Department_ID
WHERE d.Department_Name = "Mathematics" 
LIMIT 5;

-- 4. Get the number of students enrolled in each course, filtering for courses with more than 5 students.
SELECT c.Course_Name, COUNT(e.Student_ID) AS Total_Students
FROM Courses AS c
INNER JOIN Enrollments AS e
ON c.Course_ID = e.Course_ID
GROUP BY c.Course_Name
HAVING COUNT(e.Student_ID) > 5;

-- -- 5. Find students enrolled in BOTH Introduction to SQL
-- and Data Structures.

SELECT s.Student_ID, s.Student_Name
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


-- 6. Find students enrolled in EITHER Introduction to SQL
-- or Data Structures.

SELECT DISTINCT s.Student_ID, s.Student_Name
FROM students s
INNER JOIN enrollments e
    ON s.Student_ID = e.Student_ID
INNER JOIN courses c 
ON e.Course_ID = c.Course_ID
WHERE c.Course_Name IN('Introduction to SQL', 'Data Structures');


-- 7. Calculate the average number of credits for all courses.

SELECT AVG(credits) AS Average_Credits
FROM courses;


-- 8. Find the maximum salary of instructors
-- in the Computer Science department.

SELECT MAX(i.salary) AS Maximum_Salary
FROM instructors i
INNER JOIN departments d
ON i.Department_ID = d.Department_ID
WHERE d.Department_Name = 'Computer Science';


-- 9. Count the number of students enrolled in each department.

SELECT d.Department_Name,
COUNT(s.Student_ID) AS Total_Students
FROM departments d
LEFT JOIN students s
ON d.Department_ID = s.Department_ID
GROUP BY d.Department_Name;


-- 10. INNER JOIN: Retrieve students and their corresponding courses.

SELECT s.Student_ID,
s.Student_Name,
c.Course_Name
FROM students s
INNER JOIN enrollments e
ON s.Student_ID = e.Student_ID
INNER JOIN courses c
ON e.Course_ID = c.Course_ID;


-- 11. LEFT JOIN: Retrieve all students and their corresponding
-- courses, if any.

SELECT s.Student_ID,
s.Student_Name,
c.Course_Name
FROM students s
LEFT JOIN enrollments e
ON s.Student_ID = e.Student_ID
LEFT JOIN courses c
ON e.Course_ID = c.Course_ID;


-- 12. Subquery: Find students enrolled in courses that have more than 10 students.

SELECT Student_ID, Student_Name
FROM students

WHERE Student_ID IN (
SELECT Student_ID
FROM enrollments
WHERE Course_ID IN (
SELECT Course_ID
FROM enrollments
GROUP BY Course_ID
HAVING COUNT(Student_ID) > 10 ));


-- 13. Extract the year from the EnrollmentDate of students.

SELECT Student_ID,
Student_Name,
YEAR(Enrollment_Date) AS Enrollment_Year
FROM students;

-- 14. Concatenate the instructor's first and last name.

SELECT Instructor_ID,
CONCAT(First_Name, ' ', Last_Name) AS Full_Name
FROM instructors;


-- 15. Calculate the running total of students enrolled in courses.

SELECT Enrollment_ID,
Student_ID,
Course_ID,
COUNT(*) OVER (
    ORDER BY Enrollment_ID
    AND CURRENT ROW
) AS Running_Total
FROM enrollments;


-- 16. Label students as Senior or Junior based on their enrollment date.

SELECT Student_ID,
Student_Name,
Enrollment_Date,
CASE
    WHEN Enrollment_Date < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS Student_Status
FROM students;
