🎓🏛️ UNIVERSITY DATABASE MANAGEMENT SYSTEM

<div align="center">🚀 UNIVERSITY DATABASE PROJECT 🚀

💻 Manage | Organize | Store | Analyze

🌟 A MySQL-Based Relational Database Management Project 🌟

"MySQL" (https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge&logo=mysql&logoColor=white)
"SQL" (https://img.shields.io/badge/SQL-Queries-orange?style=for-the-badge&logo=databricks)
"Database" (https://img.shields.io/badge/Database-Management-purple?style=for-the-badge)
"Project" (https://img.shields.io/badge/Project-Academic-success?style=for-the-badge)

📚 A smart way to manage university information using SQL!

</div>---

🌟 📌 Project Overview

Welcome to the University Database Management System! 🎓

This project is developed using MySQL to manage and organize university-related information in a structured and efficient way.

A university handles a large amount of information related to students, departments, courses, instructors, and enrollments. Managing all this information manually can be difficult and time-consuming.

💡 This project demonstrates how a relational database can simplify academic data management through SQL queries and database relationships.

The project consists of 5 main database tables and demonstrates 16 SQL query operations, covering beginner to intermediate SQL concepts.

🎯 Main Purpose

- 🏢 Manage university departments.
- 🎓 Store student information.
- 📖 Maintain course details.
- 👩‍🏫 Manage instructor records.
- 📝 Track student course enrollments.
- 🔍 Retrieve information using SQL queries.
- 📊 Analyze data using aggregate functions.
- 🔗 Establish relationships between database tables.

---

🛠️ 💻 Technologies Used

Technology| Description
🐬 MySQL| Relational Database Management System
💻 SQL| Structured Query Language
🗃️ Database| Data storage and management
🔗 Foreign Keys| Establishing relationships
🔑 Primary Keys| Uniquely identifying records

---

🗂️ 📚 Database Structure

The database name is:

"final_project"

CREATE DATABASE final_project;
USE final_project;

The database contains five tables:

🏢 1. Departments Table

The "departments" table stores information about university departments.

Column| Data Type| Description
Department_ID| INT| Unique department ID
Department_Name| VARCHAR(50)| Department name

📌 Sample Records:

- 1 – Computer Science
- 2 – Mathematics

🎓 2. Students Table

The "students" table stores student personal and enrollment information.

Column| Data Type| Description
Student_ID| INT| Unique student ID
First_name| VARCHAR(50)| Student first name
Last_name| VARCHAR(50)| Student last name
Email| VARCHAR(100)| Email address
Birth_Date| DATE| Date of birth
Enrollment_Date| DATE| University enrollment date

📌 Sample Students:

- 👨 John Doe
- 👩 Jane Smith

📖 3. Courses Table

The "courses" table stores information about courses offered by different departments.

Column| Data Type| Description
Course_ID| INT| Unique course ID
Course_Name| VARCHAR(50)| Course name
Department_ID| INT| Related department ID
Credits| INT| Course credits

📌 Sample Courses:

- 💻 Introduction to SQL
- 📊 Data Structures

👩‍🏫 4. Instructor Table

The "instructor" table stores university instructor information.

Column| Data Type| Description
Instructor_ID| INT| Unique instructor ID
First_name| VARCHAR(50)| Instructor first name
Last_name| VARCHAR(50)| Instructor last name
Email| VARCHAR(100)| Instructor email
Department_ID| INT| Related department ID

📌 Sample Instructors:

- 👩 Alice Johnson
- 👨 Bob Lee

📝 5. Enrollments Table

The "enrollments" table connects students with their selected courses.

Column| Data Type| Description
Enrollment_ID| INT| Unique enrollment ID
Student_ID| INT| Student reference
Course_ID| INT| Course reference
Enrollment_Date| DATE| Enrollment date

💡 This table helps maintain student-course relationships.

---

🔗 🧩 Database Relationships

The project uses primary keys and foreign keys to establish relationships between tables.

Relationship| Explanation
🏢 Departments → Courses| One department can offer multiple courses.
🏢 Departments → Instructors| One department can have multiple instructors.
🎓 Students → Enrollments| One student can have multiple enrollment records.
📖 Courses → Enrollments| One course can have multiple enrollment records.

🔑 Key Database Concepts

- Primary Key (PK): Uniquely identifies each record in a table.
- Foreign Key (FK): Connects one table with another table.
- Relationship: Defines how tables are associated with each other.

---

⚡ 📋 SQL Operations Performed

This project covers 16 important SQL operations and concepts.

1️⃣ CRUD Operations 🔄

CRUD stands for:

- ➕ CREATE/INSERT: Add new records.
- 🔍 READ/SELECT: Retrieve records.
- ✏️ UPDATE: Modify existing records.
- 🗑️ DELETE: Remove records.

2️⃣ WHERE Clause 🔎

Retrieves students who enrolled after 2021.

SELECT *
FROM students
WHERE Enrollment_Date > '2021-12-31';

3️⃣ INNER JOIN 🔗

Retrieves courses offered by the Mathematics department.

SELECT *
FROM courses AS c
INNER JOIN departments AS d
ON d.Department_ID = c.Department_ID
WHERE d.Department_Name = 'Mathematics'
LIMIT 5;

4️⃣ GROUP BY and HAVING 📊

Counts students enrolled in each course and filters courses with more than five students.

SELECT c.Course_Name,
COUNT(e.Student_ID) AS Total_Students
FROM courses AS c
INNER JOIN enrollments AS e
ON c.Course_ID = e.Course_ID
GROUP BY c.Course_Name
HAVING COUNT(e.Student_ID) > 5;

5️⃣ Multiple INNER JOINs 🤝

Finds students enrolled in both Introduction to SQL and Data Structures.

6️⃣ IN Operator 🔀

Finds students enrolled in either Introduction to SQL or Data Structures.

7️⃣ AVG() Function 📈

Calculates the average number of credits for all courses.

SELECT AVG(Credits) AS Average_Credits
FROM courses;

8️⃣ MAX() Function 💰

Finds the maximum salary of instructors in the Computer Science department.

9️⃣ LEFT JOIN 🏢

Counts the number of students associated with each department.

🔟 INNER JOIN 🎓

Retrieves students and their corresponding courses.

1️⃣1️⃣ LEFT JOIN 📋

Retrieves all students and their courses, including students who have not enrolled in any course.

1️⃣2️⃣ Subquery 🧠

Finds students enrolled in courses having more than ten students.

1️⃣3️⃣ YEAR() Function 📅

Extracts the enrollment year from the enrollment date.

SELECT Student_ID,
YEAR(Enrollment_Date) AS Enrollment_Year
FROM students;

1️⃣4️⃣ CONCAT() Function ✨

Combines the instructor's first name and last name.

SELECT Instructor_ID,
CONCAT(First_name, ' ', Last_name) AS Full_Name
FROM instructor;

1️⃣5️⃣ Window Function 🪟

Calculates the running total of student enrollments.

SELECT Enrollment_ID,
Student_ID,
Course_ID,
COUNT(*) OVER (
    ORDER BY Enrollment_ID
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS Running_Total
FROM enrollments;

1️⃣6️⃣ CASE Statement 🎖️

Classifies students as Senior or Junior based on their enrollment date.

SELECT Student_ID,
CONCAT(First_name, ' ', Last_name) AS Student_Name,
Enrollment_Date,
CASE
    WHEN Enrollment_Date < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS Student_Status
FROM students;

---

📊 🧠 SQL Concepts Summary

SQL Concept| Function / Keyword| Purpose
CRUD| INSERT, UPDATE, DELETE, SELECT| Data management
Filtering| WHERE| Filter records
Sorting| ORDER BY| Sort records
Limiting| LIMIT| Restrict results
Joining| INNER JOIN| Match related records
Joining| LEFT JOIN| Retrieve all left-table records
Aggregation| COUNT()| Count records
Aggregation| AVG()| Calculate average
Aggregation| MAX()| Find maximum value
Grouping| GROUP BY| Group records
Filtering Groups| HAVING| Filter grouped results
Subquery| Nested SELECT| Query inside another query
Date Function| YEAR()| Extract year
String Function| CONCAT()| Combine strings
Window Function| OVER()| Perform calculations across rows
Conditional| CASE| Apply conditional logic

---

🚀 ⚙️ How to Execute This Project

Follow these steps to run the project in MySQL Workbench.

Step 1️⃣ – Install MySQL

Download and install MySQL Server and MySQL Workbench.

Step 2️⃣ – Open MySQL Workbench

Connect to your local MySQL server.

Step 3️⃣ – Create Database

CREATE DATABASE final_project;
USE final_project;

Step 4️⃣ – Create Tables

Create all five tables with their appropriate columns and constraints.

Step 5️⃣ – Insert Records

Insert sample data into departments, students, courses, instructors, and enrollments.

Step 6️⃣ – Execute Queries

Run the 16 SQL queries one by one.

Step 7️⃣ – Verify Results

SHOW TABLES;

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM instructor;
SELECT * FROM enrollments;

🎉 Congratulations! Your university database is ready to explore.

---

💡 Note: The current sample data contains only two students and two enrollments. Queries requiring more than five or ten students need additional sample records to demonstrate their results.

---

🎯 📚 Learning Outcomes

By completing this project, I gain practical knowledge of:

- 🏗️ Creating and managing relational databases.
- 🔑 Understanding primary and foreign keys.
- 📥 Inserting and managing database records.
- ✏️ Updating and deleting records.
- 🔍 Retrieving data using SQL queries.
- 🔗 Combining multiple tables using joins.
- 📊 Performing calculations using aggregate functions.
- 🧩 Writing nested SQL queries.
- 📅 Working with SQL date functions.
- ✨ Using string functions.
- 🪟 Understanding window functions.
- 🎖️ Implementing conditional logic using CASE statements.

---

🔮 🌈 Future Enhancements

This project can be extended with additional features to make it more advanced.

- 👤 Student Login System: Manage student accounts.
- 🏫 Classroom Management: Maintain classroom details.
- 📅 Timetable Management: Manage class schedules.
- 📝 Examination Management: Store exam records and marks.
- 💰 Fee Management: Track student fee payments.
- 📊 Dashboard Integration: Display database insights visually.
- 🔔 SQL Triggers: Automatically perform actions when data changes.
- ⚙️ Stored Procedures: Simplify frequently used SQL operations.
- 🔐 Database Security: Improve access control and data protection.

---

🏆 💡 Conclusion

The University Database Management System is a practical demonstration of how SQL can be used to manage university information efficiently.

Through this project, we explore database creation, table relationships, CRUD operations, joins, aggregate functions, subqueries, date functions, string functions, and window functions.

It provides a strong foundation for understanding relational databases and applying SQL concepts to real-world scenarios.

🌟 Every query is a step toward becoming a better SQL developer!

---

👨‍💻 About the Developer

Details| Information
👤 Name| Your Name
🎓 Project| University Database Management System
📚 Subject| Database Management System (DBMS)
🐬 Database| MySQL
💻 Language| SQL
📅 Year| 2026
🏷️ Project Type| Academic Final Project

---

💖 THANK YOU FOR VISITING! 💖

🌟 KEEP LEARNING • KEEP BUILDING • KEEP GROWING 🌟

🚀 SQL + LOGIC + PRACTICE = SUCCESS!

⭐ If you find this project useful, don't forget to give it a star! ⭐

</div>
