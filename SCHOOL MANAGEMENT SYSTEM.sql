create database school_management;
use school_management;

CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(20) NOT NULL,
    section VARCHAR(5) NOT NULL,
    class_teacher_id INT
);


CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    hire_date DATE
);

-- SUBJECT TABLE
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    max_marks INT DEFAULT 100
);


CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    admission_date DATE,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- TEACHER SUBJECT TABLE
CREATE TABLE teacher_subject (
    teacher_id INT,
    subject_id INT,
    class_id INT,
    PRIMARY KEY (teacher_id, subject_id, class_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);


CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    academic_year VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- MARKS TABLE
CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    exam_type VARCHAR(30),
    marks_obtained DECIMAL(5,2),
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- ATTENDANCE TABLE
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    attendance_date DATE,
    status ENUM('Present','Absent','Late') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    fee_type VARCHAR(50),
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_status ENUM('Paid','Pending') DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

use school_management;
# teacher
INSERT INTO teachers
(teacher_name, gender, phone, email, hire_date)
VALUES
('Amit Sharma','Male','9876500001','amit@school.com','2020-06-10'),
('Priya Patel','Female','9876500002','priya@school.com','2021-06-15'),
('Rahul Mehta','Male','9876500003','rahul@school.com','2019-07-01'),
('Sneha Joshi','Female','9876500004','sneha@school.com','2022-04-10'),
('Vikas Singh','Male','9876500005','vikas@school.com','2020-08-20'),
('Neha Khan','Female','9876500006','neha@school.com','2021-09-01');

# subjects
INSERT INTO subjects
(subject_name, max_marks)
VALUES
('Mathematics',100),
('Science',100),
('English',100),
('Hindi',100),
('Computer Science',100),
('Social Science',100);

INSERT INTO classes
(class_name, section, class_teacher_id)
VALUES
('10','A',NULL),
('10','B',NULL),
('9','A',NULL),
('9','B',NULL);

UPDATE classes
SET class_teacher_id = 1
WHERE class_id = 1;

UPDATE classes
SET class_teacher_id = 2
WHERE class_id = 2;

UPDATE classes
SET class_teacher_id = 3
WHERE class_id = 3;

UPDATE classes
SET class_teacher_id = 4
WHERE class_id = 4;

INSERT INTO students
(student_name, gender, date_of_birth, phone, email, address, admission_date, class_id)
VALUES
('Aarav Sharma','Male','2010-04-12','9000000001','aarav@gmail.com','Mumbai','2025-06-10',1),
('Ananya Patel','Female','2010-07-18','9000000002','ananya@gmail.com','Mumbai','2025-06-10',1),
('Arjun Mehta','Male','2010-02-25','9000000003','arjun@gmail.com','Mumbai','2025-06-11',1),
('Aisha Khan','Female','2010-09-11','9000000004','aisha@gmail.com','Mumbai','2025-06-11',1),
('Rohan Singh','Male','2010-05-19','9000000005','rohan@gmail.com','Mumbai','2025-06-12',1),

('Ishita Joshi','Female','2011-01-14','9000000006','ishita@gmail.com','Mumbai','2025-06-12',2),
('Kabir Shah','Male','2011-03-21','9000000007','kabir@gmail.com','Mumbai','2025-06-13',2),
('Diya Verma','Female','2011-06-09','9000000008','diya@gmail.com','Mumbai','2025-06-13',2),
('Aditya Rao','Male','2011-08-16','9000000009','aditya@gmail.com','Mumbai','2025-06-14',2),
('Meera Desai','Female','2011-10-22','9000000010','meera@gmail.com','Mumbai','2025-06-14',2),

('Vivaan Gupta','Male','2011-02-10','9000000011','vivaan@gmail.com','Mumbai','2025-06-15',3),
('Sara Sheikh','Female','2011-04-18','9000000012','sara@gmail.com','Mumbai','2025-06-15',3),
('Aryan Kapoor','Male','2011-07-23','9000000013','aryan@gmail.com','Mumbai','2025-06-16',3),
('Myra Jain','Female','2011-09-05','9000000014','myra@gmail.com','Mumbai','2025-06-16',3),
('Reyansh Nair','Male','2011-11-12','9000000015','reyansh@gmail.com','Mumbai','2025-06-17',3),

('Kiara Malhotra','Female','2012-01-08','9000000016','kiara@gmail.com','Mumbai','2025-06-17',4),
('Atharv Kulkarni','Male','2012-03-15','9000000017','atharv@gmail.com','Mumbai','2025-06-18',4),
('Avni Bhat','Female','2012-05-20','9000000018','avni@gmail.com','Mumbai','2025-06-18',4),
('Dev Patil','Male','2012-08-25','9000000019','dev@gmail.com','Mumbai','2025-06-19',4),
('Tara Mishra','Female','2012-10-30','9000000020','tara@gmail.com','Mumbai','2025-06-19',4);


INSERT INTO enrollments
(student_id, subject_id, academic_year)
SELECT 
    s.student_id,
    sub.subject_id,
    '2025-2026'
FROM students s
CROSS JOIN subjects sub;


INSERT INTO marks
(student_id, subject_id, exam_type, marks_obtained, exam_date)
VALUES
(41,1,'Final Exam',85,'2026-03-10'),
(41,2,'Final Exam',78,'2026-03-11'),
(41,3,'Final Exam',88,'2026-03-12'),
(41,4,'Final Exam',82,'2026-03-13'),
(41,5,'Final Exam',92,'2026-03-14'),
(41,6,'Final Exam',80,'2026-03-15'),

(42,1,'Final Exam',90,'2026-03-10'),
(42,2,'Final Exam',86,'2026-03-11'),
(42,3,'Final Exam',91,'2026-03-12'),
(42,4,'Final Exam',89,'2026-03-13'),
(42,5,'Final Exam',95,'2026-03-14'),
(42,6,'Final Exam',87,'2026-03-15'),

(43,1,'Final Exam',75,'2026-03-10'),
(43,2,'Final Exam',80,'2026-03-11'),
(43,3,'Final Exam',77,'2026-03-12'),
(43,4,'Final Exam',70,'2026-03-13'),
(43,5,'Final Exam',88,'2026-03-14'),
(43,6,'Final Exam',76,'2026-03-15');

INSERT INTO marks
(student_id, subject_id, exam_type, marks_obtained, exam_date)
VALUES

(44,1,'Final Exam',82,'2026-03-10'),
(44,2,'Final Exam',85,'2026-03-10'),
(44,3,'Final Exam',84,'2026-03-10'),
(44,4,'Final Exam',79,'2026-03-10'),
(44,5,'Final Exam',90,'2026-03-10'),
(44,6,'Final Exam',81,'2026-03-10'),

(45,1,'Final Exam',68,'2026-03-10'),
(45,2,'Final Exam',72,'2026-03-10'),
(45,3,'Final Exam',75,'2026-03-10'),
(45,4,'Final Exam',70,'2026-03-10'),
(45,5,'Final Exam',80,'2026-03-10'),
(45,6,'Final Exam',74,'2026-03-10'),

(46,1,'Final Exam',95,'2026-03-10'),
(46,2,'Final Exam',92,'2026-03-10'),
(46,3,'Final Exam',94,'2026-03-10'),
(46,4,'Final Exam',90,'2026-03-10'),
(46,5,'Final Exam',98,'2026-03-10'),
(46,6,'Final Exam',93,'2026-03-10'),

(47,1,'Final Exam',88,'2026-03-10'),
(47,2,'Final Exam',84,'2026-03-10'),
(47,3,'Final Exam',86,'2026-03-10'),
(47,4,'Final Exam',91,'2026-03-10'),
(47,5,'Final Exam',89,'2026-03-10'),
(47,6,'Final Exam',85,'2026-03-10'),

(48,1,'Final Exam',72,'2026-03-10'),
(48,2,'Final Exam',75,'2026-03-10'),
(48,3,'Final Exam',70,'2026-03-10'),
(48,4,'Final Exam',78,'2026-03-10'),
(48,5,'Final Exam',82,'2026-03-10'),
(48,6,'Final Exam',76,'2026-03-10'),

(49,1,'Final Exam',91,'2026-03-10'),
(49,2,'Final Exam',89,'2026-03-10'),
(49,3,'Final Exam',93,'2026-03-10'),
(49,4,'Final Exam',87,'2026-03-10'),
(49,5,'Final Exam',96,'2026-03-10'),
(49,6,'Final Exam',90,'2026-03-10'),

(50,1,'Final Exam',65,'2026-03-10'),
(50,2,'Final Exam',70,'2026-03-10'),
(50,3,'Final Exam',68,'2026-03-10'),
(50,4,'Final Exam',74,'2026-03-10'),
(50,5,'Final Exam',72,'2026-03-10'),
(50,6,'Final Exam',69,'2026-03-10'),

(51,1,'Final Exam',79,'2026-03-10'),
(51,2,'Final Exam',83,'2026-03-10'),
(51,3,'Final Exam',81,'2026-03-10'),
(51,4,'Final Exam',77,'2026-03-10'),
(51,5,'Final Exam',85,'2026-03-10'),
(51,6,'Final Exam',80,'2026-03-10'),

(52,1,'Final Exam',87,'2026-03-10'),
(52,2,'Final Exam',90,'2026-03-10'),
(52,3,'Final Exam',85,'2026-03-10'),
(52,4,'Final Exam',88,'2026-03-10'),
(52,5,'Final Exam',91,'2026-03-10'),
(52,6,'Final Exam',86,'2026-03-10'),

(53,1,'Final Exam',73,'2026-03-10'),
(53,2,'Final Exam',69,'2026-03-10'),
(53,3,'Final Exam',76,'2026-03-10'),
(53,4,'Final Exam',72,'2026-03-10'),
(53,5,'Final Exam',79,'2026-03-10'),
(53,6,'Final Exam',75,'2026-03-10'),

(54,1,'Final Exam',94,'2026-03-10'),
(54,2,'Final Exam',91,'2026-03-10'),
(54,3,'Final Exam',96,'2026-03-10'),
(54,4,'Final Exam',93,'2026-03-10'),
(54,5,'Final Exam',97,'2026-03-10'),
(54,6,'Final Exam',92,'2026-03-10'),

(55,1,'Final Exam',81,'2026-03-10'),
(55,2,'Final Exam',78,'2026-03-10'),
(55,3,'Final Exam',83,'2026-03-10'),
(55,4,'Final Exam',80,'2026-03-10'),
(55,5,'Final Exam',86,'2026-03-10'),
(55,6,'Final Exam',79,'2026-03-10'),

(56,1,'Final Exam',69,'2026-03-10'),
(56,2,'Final Exam',74,'2026-03-10'),
(56,3,'Final Exam',71,'2026-03-10'),
(56,4,'Final Exam',68,'2026-03-10'),
(56,5,'Final Exam',77,'2026-03-10'),
(56,6,'Final Exam',73,'2026-03-10'),

(57,1,'Final Exam',92,'2026-03-10'),
(57,2,'Final Exam',88,'2026-03-10'),
(57,3,'Final Exam',90,'2026-03-10'),
(57,4,'Final Exam',94,'2026-03-10'),
(57,5,'Final Exam',93,'2026-03-10'),
(57,6,'Final Exam',89,'2026-03-10'),

(58,1,'Final Exam',76,'2026-03-10'),
(58,2,'Final Exam',81,'2026-03-10'),
(58,3,'Final Exam',79,'2026-03-10'),
(58,4,'Final Exam',75,'2026-03-10'),
(58,5,'Final Exam',84,'2026-03-10'),
(58,6,'Final Exam',80,'2026-03-10'),

(59,1,'Final Exam',84,'2026-03-10'),
(59,2,'Final Exam',87,'2026-03-10'),
(59,3,'Final Exam',82,'2026-03-10'),
(59,4,'Final Exam',86,'2026-03-10'),
(59,5,'Final Exam',88,'2026-03-10'),
(59,6,'Final Exam',85,'2026-03-10'),

(60,1,'Final Exam',89,'2026-03-10'),
(60,2,'Final Exam',85,'2026-03-10'),
(60,3,'Final Exam',91,'2026-03-10'),
(60,4,'Final Exam',90,'2026-03-10'),
(60,5,'Final Exam',94,'2026-03-10'),
(60,6,'Final Exam',88,'2026-03-10');

INSERT INTO attendance
(student_id, attendance_date, status)
SELECT
    s.student_id,
    DATE_ADD('2026-06-01', INTERVAL d.day_no DAY),
    CASE
        WHEN s.student_id IN (46,49,54) THEN 'Present'

        WHEN s.student_id IN (42,52,60)
             AND d.day_no = 5 THEN 'Absent'

        WHEN s.student_id IN (41)
             AND d.day_no = 5 THEN 'Absent'
        WHEN s.student_id IN (41)
             AND d.day_no = 10 THEN 'Late'

        WHEN s.student_id IN (43)
             AND d.day_no IN (3,12) THEN 'Absent'
        WHEN s.student_id IN (43)
             AND d.day_no = 15 THEN 'Late'

        WHEN s.student_id IN (44)
             AND d.day_no IN (4,14) THEN 'Absent'

        WHEN s.student_id IN (45)
             AND d.day_no IN (2,8,15) THEN 'Absent'
        WHEN s.student_id IN (45)
             AND d.day_no = 18 THEN 'Late'

        WHEN s.student_id IN (47)
             AND d.day_no = 7 THEN 'Late'

        WHEN s.student_id IN (48)
             AND d.day_no IN (4,11) THEN 'Absent'
        WHEN s.student_id IN (48)
             AND d.day_no = 16 THEN 'Late'

        WHEN s.student_id IN (50)
             AND d.day_no IN (2,6,10,15) THEN 'Absent'
        WHEN s.student_id IN (50)
             AND d.day_no = 18 THEN 'Late'

        WHEN s.student_id IN (51)
             AND d.day_no = 6 THEN 'Absent'
        WHEN s.student_id IN (51)
             AND d.day_no = 16 THEN 'Late'

        WHEN s.student_id IN (53)
             AND d.day_no IN (3,8,14) THEN 'Absent'
        WHEN s.student_id IN (53)
             AND d.day_no = 17 THEN 'Late'

        WHEN s.student_id IN (55)
             AND d.day_no IN (5,13) THEN 'Absent'

        WHEN s.student_id IN (56)
             AND d.day_no IN (2,6,11,17) THEN 'Absent'
        WHEN s.student_id IN (56)
             AND d.day_no = 19 THEN 'Late'

        WHEN s.student_id IN (57)
             AND d.day_no = 9 THEN 'Late'

        WHEN s.student_id IN (58)
             AND d.day_no IN (4,12) THEN 'Absent'
        WHEN s.student_id IN (58)
             AND d.day_no = 16 THEN 'Late'

        WHEN s.student_id IN (59)
             AND d.day_no = 7 THEN 'Absent'
        WHEN s.student_id IN (59)
             AND d.day_no = 18 THEN 'Late'

        ELSE 'Present'
    END
FROM students s
CROSS JOIN (
    SELECT 0 AS day_no
    UNION ALL SELECT 1
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6
    UNION ALL SELECT 7
    UNION ALL SELECT 8
    UNION ALL SELECT 9
    UNION ALL SELECT 10
    UNION ALL SELECT 11
    UNION ALL SELECT 12
    UNION ALL SELECT 13
    UNION ALL SELECT 14
    UNION ALL SELECT 15
    UNION ALL SELECT 16
    UNION ALL SELECT 17
    UNION ALL SELECT 18
    UNION ALL SELECT 19
) d
WHERE s.student_id BETWEEN 41 AND 60;

INSERT INTO fees
(student_id, fee_type, amount, payment_date, payment_status)
VALUES

-- 41 Aarav Sharma
(41,'Tuition Fee',30000,'2026-06-05','Paid'),
(41,'Exam Fee',2000,'2026-06-05','Paid'),
(41,'Library Fee',1000,'2026-06-05','Paid'),
(41,'Transport Fee',5000,'2026-06-05','Paid'),

-- 42 Ananya Patel
(42,'Tuition Fee',30000,'2026-06-06','Paid'),
(42,'Exam Fee',2000,'2026-06-06','Paid'),
(42,'Library Fee',1000,'2026-06-06','Paid'),
(42,'Transport Fee',5000,'2026-06-06','Pending'),

-- 43 Arjun Mehta
(43,'Tuition Fee',30000,'2026-06-07','Paid'),
(43,'Exam Fee',2000,'2026-06-07','Paid'),
(43,'Library Fee',1000,'2026-06-07','Paid'),

-- 44 Aisha Khan
(44,'Tuition Fee',30000,'2026-06-08','Paid'),
(44,'Exam Fee',2000,'2026-06-08','Pending'),
(44,'Library Fee',1000,'2026-06-08','Pending'),
(44,'Transport Fee',5000,'2026-06-08','Pending'),

-- 45 Rohan Singh
(45,'Tuition Fee',30000,'2026-06-09','Pending'),
(45,'Exam Fee',2000,'2026-06-09','Paid'),
(45,'Library Fee',1000,'2026-06-09','Paid'),

-- 46 Ishita Joshi
(46,'Tuition Fee',30000,'2026-06-10','Paid'),
(46,'Exam Fee',2000,'2026-06-10','Paid'),
(46,'Library Fee',1000,'2026-06-10','Paid'),
(46,'Transport Fee',5000,'2026-06-10','Paid'),

-- 47 Kabir Shah
(47,'Tuition Fee',30000,'2026-06-11','Paid'),
(47,'Exam Fee',2000,'2026-06-11','Paid'),
(47,'Library Fee',1000,'2026-06-11','Paid'),

-- 48 Diya Verma
(48,'Tuition Fee',30000,'2026-06-12','Paid'),
(48,'Exam Fee',2000,'2026-06-12','Paid'),
(48,'Library Fee',1000,'2026-06-12','Paid'),
(48,'Transport Fee',5000,'2026-06-12','Pending'),

-- 49 Aditya Rao
(49,'Tuition Fee',30000,'2026-06-13','Paid'),
(49,'Exam Fee',2000,'2026-06-13','Paid'),
(49,'Library Fee',1000,'2026-06-13','Paid'),
(49,'Transport Fee',5000,'2026-06-13','Paid'),

-- 50 Meera Desai
(50,'Tuition Fee',30000,'2026-06-14','Pending'),
(50,'Exam Fee',2000,'2026-06-14','Paid'),
(50,'Library Fee',1000,'2026-06-14','Pending'),

-- 51 Vivaan Gupta
(51,'Tuition Fee',30000,'2026-06-15','Paid'),
(51,'Exam Fee',2000,'2026-06-15','Paid'),
(51,'Library Fee',1000,'2026-06-15','Paid'),
(51,'Transport Fee',5000,'2026-06-15','Pending'),

-- 52 Sara Sheikh
(52,'Tuition Fee',30000,'2026-06-16','Paid'),
(52,'Exam Fee',2000,'2026-06-16','Paid'),
(52,'Library Fee',1000,'2026-06-16','Paid'),

-- 53 Aryan Kapoor
(53,'Tuition Fee',30000,'2026-06-17','Paid'),
(53,'Exam Fee',2000,'2026-06-17','Pending'),
(53,'Library Fee',1000,'2026-06-17','Pending'),
(53,'Transport Fee',5000,'2026-06-17','Pending'),

-- 54 Myra Jain
(54,'Tuition Fee',30000,'2026-06-18','Paid'),
(54,'Exam Fee',2000,'2026-06-18','Paid'),
(54,'Library Fee',1000,'2026-06-18','Paid'),
(54,'Transport Fee',5000,'2026-06-18','Paid'),

-- 55 Reyansh Nair
(55,'Tuition Fee',30000,'2026-06-19','Paid'),
(55,'Exam Fee',2000,'2026-06-19','Pending'),
(55,'Library Fee',1000,'2026-06-19','Paid'),

-- 56 Kiara Malhotra
(56,'Tuition Fee',30000,'2026-06-20','Pending'),
(56,'Exam Fee',2000,'2026-06-20','Paid'),
(56,'Library Fee',1000,'2026-06-20','Pending'),
(56,'Transport Fee',5000,'2026-06-20','Pending'),

-- 57 Atharv Kulkarni
(57,'Tuition Fee',30000,'2026-06-21','Paid'),
(57,'Exam Fee',2000,'2026-06-21','Paid'),
(57,'Library Fee',1000,'2026-06-21','Paid'),

-- 58 Avni Bhat
(58,'Tuition Fee',30000,'2026-06-22','Paid'),
(58,'Exam Fee',2000,'2026-06-22','Paid'),
(58,'Library Fee',1000,'2026-06-22','Paid'),
(58,'Transport Fee',5000,'2026-06-22','Pending'),

-- 59 Dev Patil
(59,'Tuition Fee',30000,'2026-06-23','Paid'),
(59,'Exam Fee',2000,'2026-06-23','Pending'),
(59,'Library Fee',1000,'2026-06-23','Paid'),

-- 60 Tara Mishra
(60,'Tuition Fee',30000,'2026-06-24','Paid'),
(60,'Exam Fee',2000,'2026-06-24','Paid'),
(60,'Library Fee',1000,'2026-06-24','Paid'),
(60,'Transport Fee',5000,'2026-06-24','Paid');

use school_management;
# overall student performance
SELECT
    s.student_id,
    s.student_name,
    c.class_name,
    c.section,
    SUM(m.marks_obtained) AS total_marks,
    COUNT(m.subject_id) AS subjects,
    ROUND(AVG(m.marks_obtained),2) AS average_marks,
    ROUND(
        (SUM(m.marks_obtained) / (COUNT(m.subject_id) * 100)) * 100,
        2
    ) AS percentage,
    
    CASE
        WHEN AVG(m.marks_obtained) >= 90 THEN 'A+'
        WHEN AVG(m.marks_obtained) >= 80 THEN 'A'
        WHEN AVG(m.marks_obtained) >= 70 THEN 'B'
        WHEN AVG(m.marks_obtained) >= 60 THEN 'C'
        WHEN AVG(m.marks_obtained) >= 50 THEN 'D'
        ELSE 'F'
    END AS grade

FROM students s

JOIN classes c
    ON s.class_id = c.class_id

JOIN marks m
    ON s.student_id = m.student_id

GROUP BY
    s.student_id,
    s.student_name,
    c.class_name,
    c.section
ORDER BY percentage DESC;

# Total marks of each studnets 
SELECT
    student_id,
    SUM(marks_obtained) AS total_marks
FROM marks
GROUP BY student_id;

# who gets more than 80 marks
SELECT
    student_id,
    subject_id,
    marks_obtained
FROM marks
WHERE marks_obtained > 80;

#Which student has the highest overall performance?
SELECT
    student_id,
    AVG(marks_obtained) AS average_marks
FROM marks
GROUP BY student_id
ORDER BY average_marks DESC
LIMIT 1;

# Which subject has the highest average marks?

SELECT
    subject_id,
    AVG(marks_obtained) AS average_marks
FROM marks
GROUP BY subject_id
ORDER BY average_marks DESC
LIMIT 1;

# Which subject is the most difficult for students?
SELECT
    subject_id,
    AVG(marks_obtained) AS average_marks
FROM marks
GROUP BY subject_id
ORDER BY average_marks ASC
LIMIT 1;

# How do you identify students who are academically weak?
SELECT
    student_id,
    AVG(marks_obtained) AS average_marks
FROM marks
GROUP BY student_id
HAVING AVG(marks_obtained) < 50;

# Top 5 students 
SELECT
    student_id,
    AVG(marks_obtained) AS average_marks
FROM marks
GROUP BY student_id
ORDER BY average_marks DESC
LIMIT 5;

# attendance of all students
SELECT
    s.student_id,
    s.student_name,
    SUM(a.status = 'Present') AS present_days,
    SUM(a.status = 'Absent') AS absent_days,
    SUM(a.status = 'Late') AS late_days,
    ROUND(
        SUM(a.status = 'Present') /
        COUNT(a.attendance_id) * 100,
        2
    ) AS attendance_percentage
FROM students s
JOIN attendance a
    ON s.student_id = a.student_id
WHERE s.student_id BETWEEN 41 AND 60
GROUP BY
    s.student_id,
    s.student_name
ORDER BY s.student_id;

# overall fees collection 
SELECT
    SUM(CASE WHEN payment_status = 'Paid' THEN amount ELSE 0 END) AS total_paid,
    SUM(CASE WHEN payment_status = 'Pending' THEN amount ELSE 0 END) AS total_pending
FROM fees;

# students wise fees collection 
SELECT
    s.student_id,
    s.student_name,
    SUM(f.amount) AS total_fee,
    SUM(CASE
        WHEN f.payment_status = 'Paid'
        THEN f.amount ELSE 0
    END) AS paid_amount,
    SUM(CASE
        WHEN f.payment_status = 'Pending'
        THEN f.amount ELSE 0
    END) AS pending_amount
FROM students s
JOIN fees f
    ON s.student_id = f.student_id
GROUP BY s.student_id, s.student_name
ORDER BY s.student_id;

# which students have pending fees 
SELECT
    s.student_id,
    s.student_name,
    SUM(f.amount) AS pending_amount
FROM students s
JOIN fees f
    ON s.student_id = f.student_id
WHERE f.payment_status = 'Pending'
GROUP BY s.student_id, s.student_name
ORDER BY pending_amount DESC;

# How much fee is still pending?

SELECT
    SUM(amount) AS pending_fee
FROM fees
WHERE payment_status = 'Pending';

# How much total fee has been collected?
SELECT
    SUM(amount) AS total_fee
FROM fees;

#What is the total fee collection by fee type?

SELECT
    fee_type,
    SUM(amount) AS total_collection
FROM fees
WHERE payment_status = 'Paid'
GROUP BY fee_type
ORDER BY total_collection DESC;

#What is the total fee collection by fee type?
SELECT
    fee_type,
    SUM(amount) AS total_collection
FROM fees
WHERE payment_status = "pending"
GROUP BY fee_type
ORDER BY total_collection DESC;

# identify students who have both low marks and low attendance?
SELECT
    s.student_name,
    ROUND(AVG(m.marks_obtained),2) AS average_marks,
    ROUND(
        SUM(a.status = 'Present') /
        COUNT(a.attendance_id) * 100, 2
    ) AS attendance_percentage
FROM students s
JOIN marks m
    ON s.student_id = m.student_id
JOIN attendance a
    ON s.student_id = a.student_id
GROUP BY s.student_id, s.student_name
HAVING average_marks < 60
   AND attendance_percentage < 75;
   
   
# overall student performance
 CREATE VIEW overall_student_performance AS
SELECT
    s.student_id,
    s.student_name,
    c.class_name,
    c.section,
    SUM(m.marks_obtained) AS total_marks,
    COUNT(m.subject_id) AS subjects,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks,
    ROUND(
        (SUM(m.marks_obtained) / (COUNT(m.subject_id) * 100)) * 100,
        2
    ) AS percentage,

    CASE
        WHEN AVG(m.marks_obtained) >= 90 THEN 'A+'
        WHEN AVG(m.marks_obtained) >= 80 THEN 'A'
        WHEN AVG(m.marks_obtained) >= 70 THEN 'B'
        WHEN AVG(m.marks_obtained) >= 60 THEN 'C'
        WHEN AVG(m.marks_obtained) >= 50 THEN 'D'
        ELSE 'F'
    END AS grade

FROM students s

JOIN classes c
    ON s.class_id = c.class_id

JOIN marks m
    ON s.student_id = m.student_id

GROUP BY
    s.student_id,
    s.student_name,
    c.class_name,
    c.section;
    
select * from overall_student_performance;

create view fees_details as 
SELECT
    s.student_id,
    s.student_name,
    SUM(f.amount) AS total_fee,
    SUM(CASE
        WHEN f.payment_status = 'Paid'
        THEN f.amount ELSE 0
    END) AS paid_amount,
    SUM(CASE
        WHEN f.payment_status = 'Pending'
        THEN f.amount ELSE 0
    END) AS pending_amount
FROM students s
JOIN fees f
    ON s.student_id = f.student_id
GROUP BY s.student_id, s.student_name
ORDER BY s.student_id;
select * from fees_details;
 