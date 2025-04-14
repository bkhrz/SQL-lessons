DROP TABLE IF EXISTS student;
CREATE TABLE student(
    student_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(255),
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS classes * tuition_per_class
);

INSERT INTO student (name, classes, tuition_per_class)
VALUES
('Alice', 4, 250.00),
('Bob', 3, 300.00),
('Charlie', 5, 200.00);

SELECT * FROM student;