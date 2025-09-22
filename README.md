# 🎓 Student Management System Database

This project contains a **MySQL relational database schema** designed to manage student records for a university or college.  
The database provides a structured way to store and retrieve **students, courses, departments, lecturers, enrollments, and grades**.

---

## 📚 Features
- **Well-structured tables** with proper constraints (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`).
- **Entity relationships**:
  - One-to-Many: Departments → Students, Departments → Courses, Lecturers → Courses
  - Many-to-Many: Students ↔ Courses (via Enrollments)
- Sample **data inserts** to test relationships and run example queries.

---

## 🏛️ Database Structure
The database contains the following main tables:

| Table         | Description |
|----------------|-------------|
| **Departments** | Stores department details (e.g., Computer Science, Business). |
| **Students**    | Stores student personal info and department association. |
| **Lecturers**   | Stores lecturer details and their department. |
| **Courses**     | Stores courses offered and links each course to a lecturer and department. |
| **Enrollments** | Junction table linking students to courses (many-to-many). |
| **Grades**      | Records student grades for each course enrollment. |

---

## 🗂️ File Contents
- **student_records.sql**  
  Contains:
  - `CREATE DATABASE` statement  
  - `CREATE TABLE` statements with constraints  
  - Sample `INSERT` statements to populate the tables with test data

---

## ⚡ Getting Started

### Requirements
- [MySQL Server](https://dev.mysql.com/downloads/) installed locally or accessible remotely.
- MySQL client (CLI or GUI such as MySQL Workbench, phpMyAdmin, DBeaver, etc.).

