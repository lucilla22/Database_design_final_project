-- ================================================
-- 1️⃣  CREATE DATABASE
-- ================================================
CREATE DATABASE IF NOT EXISTS StudentManagementSystem;
USE StudentManagementSystem;

-- ================================================
-- 2️⃣  CREATE TABLES
-- ================================================

-- Departments Table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    office_location VARCHAR(100)
);

-- Students Table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    department_id INT,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id) 
        REFERENCES Departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Lecturers Table
CREATE TABLE Lecturers (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE DEFAULT CURRENT_DATE,
    department_id INT,
    CONSTRAINT fk_lecturer_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL CHECK (credit_hours BETWEEN 1 AND 6),
    department_id INT,
    lecturer_id INT,
    CONSTRAINT fk_course_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_course_lecturer
        FOREIGN KEY (lecturer_id)
        REFERENCES Lecturers(lecturer_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Enrollments Table (junction for Many-to-Many)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester ENUM('Spring','Summer','Fall') NOT NULL,
    academic_year YEAR NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_enroll_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_student_course UNIQUE(student_id, course_id, academic_year, semester)
);

-- Grades Table
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    grade CHAR(2) CHECK (grade IN ('A','B','C','D','F','I')),
    grade_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_grade_enrollment
        FOREIGN KEY (enrollment_id)
        REFERENCES Enrollments(enrollment_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
USE StudentManagementSystem;

-- ================================================
-- 1️⃣  Insert Departments
-- ================================================
INSERT INTO Departments (department_name, office_location)
VALUES 
('Computer Science', 'Block A'),
('Business Administration', 'Block B'),
('Electrical Engineering', 'Block C'),
('Mathematics', 'Block D');

-- ================================================
-- 2️⃣  Insert Lecturers
-- ================================================
INSERT INTO Lecturers (first_name, last_name, email, hire_date, department_id)
VALUES
('Alice', 'Johnson', 'alice.johnson@university.edu', '2020-02-10', 1),
('Brian', 'Smith', 'brian.smith@university.edu', '2019-08-05', 2),
('Clara', 'Omondi', 'clara.omondi@university.edu', '2021-01-12', 3),
('David', 'Mutua', 'david.mutua@university.edu', '2022-03-25', 4);

-- ================================================
-- 3️⃣  Insert Courses
-- ================================================
INSERT INTO Courses (course_code, course_name, credit_hours, department_id, lecturer_id)
VALUES
('CS101', 'Introduction to Programming', 3, 1, 1),
('CS201', 'Database Systems', 4, 1, 1),
('BUS101', 'Principles of Management', 3, 2, 2),
('EE101', 'Circuits and Electronics', 4, 3, 3),
('MATH201', 'Advanced Calculus', 3, 4, 4);

-- ================================================
-- 4️⃣  Insert Students
-- ================================================
INSERT INTO Students (first_name, last_name, date_of_birth, gender, email, phone, department_id, enrollment_date)
VALUES
('John', 'Doe', '2001-05-14', 'Male', 'john.doe@student.edu', '0700000001', 1, '2023-09-01'),
('Jane', 'Kimani', '2002-07-20', 'Female', 'jane.kimani@student.edu', '0700000002', 1, '2023-09-01'),
('Peter', 'Okoth', '2000-11-03', 'Male', 'peter.okoth@student.edu', '0700000003', 2, '2022-09-01'),
('Mary', 'Wanjiku', '2001-02-18', 'Female', 'mary.wanjiku@student.edu', '0700000004', 3, '2023-09-01'),
('Samuel', 'Ochieng', '2002-08-30', 'Male', 'samuel.ochieng@student.edu', '0700000005', 4, '2023-09-01');

-- ================================================
-- 5️⃣  Insert Enrollments
-- ================================================
INSERT INTO Enrollments (student_id, course_id, semester, academic_year, enrollment_date)
VALUES
(1, 1, 'Fall', 2023, '2023-09-05'),  -- John -> CS101
(1, 2, 'Fall', 2023, '2023-09-06'),  -- John -> CS201
(2, 1, 'Fall', 2023, '2023-09-05'),  -- Jane -> CS101
(2, 2, 'Fall', 2023, '2023-09-06'),  -- Jane -> CS201
(3, 3, 'Spring', 2023, '2023-02-10'),-- Peter -> BUS101
(4, 4, 'Fall', 2023, '2023-09-07'),  -- Mary -> EE101
(5, 5, 'Fall', 2023, '2023-09-08');  -- Samuel -> MATH201

-- ================================================
-- 6️⃣  Insert Grades
-- ================================================
INSERT INTO Grades (enrollment_id, grade, grade_date)
VALUES
(1, 'A', '2023-12-15'),
(2, 'B', '2023-12-16'),
(3, 'A', '2023-12-17'),
(4, 'B', '2023-12-18'),
(5, 'C', '2023-06-10'),
(6, 'A', '2023-12-20'),
(7, 'B', '2023-12-21');
