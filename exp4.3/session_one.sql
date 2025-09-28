-- =========================================
-- Session 1: Transactions & Concurrency Control
-- =========================================

-- =========================================
-- Setup: Create Table & Insert Data
-- =========================================

DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course_id VARCHAR(10),
    enrollment_date DATE
);

INSERT INTO StudentEnrollments VALUES
(1, 'Ashish', 'CSE101', '2024-06-01'),
(2, 'Smaran', 'CSE102', '2024-06-01'),
(3, 'Vaibhav', 'CSE103', '2024-06-01');

-- =========================================
-- Part A
-- =========================================
START TRANSACTION;

UPDATE StudentEnrollments 
SET course_id = 'CSE201' 
WHERE student_id = 1;

UPDATE StudentEnrollments 
SET course_id = 'CSE202' 
WHERE student_id = 2;

-- =========================================
-- Part B
-- =========================================
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

SELECT enrollment_date 
FROM StudentEnrollments 
WHERE student_id = 1;

SELECT enrollment_date 
FROM StudentEnrollments 
WHERE student_id = 1;

COMMIT;

-- =========================================
-- Part C
-- =========================================
START TRANSACTION;
SELECT * 
FROM StudentEnrollments 
WHERE student_id = 1 FOR UPDATE;
COMMIT;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

UPDATE StudentEnrollments 
SET enrollment_date = '2024-08-01' 
WHERE student_id = 1;

SELECT * FROM StudentEnrollments WHERE student_id = 1;

COMMIT;
