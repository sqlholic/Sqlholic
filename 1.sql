Problem:  How to find the duplicates Record and delete it.


-- Create table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    city VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO Employee (id, employee_name, city, salary) VALUES
(1, 'John Doe', 'New York', 50000.00),
(2, 'Jane Smith', 'Los Angeles', 65000.00),
(3, 'Alice Johnson', 'Chicago', 60000.00),
(4, 'Bob Brown', 'Houston', 52000.00),
(5, 'John Doe', 'New York', 50000.00), -- Duplicate entry
(6, 'Jane Smith', 'Los Angeles', 55000.00), -- Duplicate entry
(7, 'Alice Johnson', 'Chicago', 60000.00), -- Duplicate entry
(8, 'John Doe', 'Miami', 48000.00),
(9, 'Jane Smith', 'Boston', 57000.00),
(10, 'Charlie Lee', 'San Francisco', 62000.00);





------------------------Solutions-----------------------------------
-------------------------------------------------------------------
Method- 1
  -- Query to find duplicates Using Group By-------------
SELECT employee_name, city, COUNT(*) AS duplicate_count
FROM Employee
GROUP BY employee_name, city
HAVING COUNT(*) > 1;


Method- 2
----Query to find duplicates Using Sub Query--------------
SELECT * FROM Employee
---DELETE FROM  Employee   --For deleting duplicates 
WHERE EXISTS (
    SELECT 1
    FROM Employee AS e2
    WHERE Employee.employee_name = e2.employee_name
    AND Employee.city = e2.city
    AND Employee.ID > e2.ID
);


Method- 3
-- Query to find duplicates Using CTE-----------------------
WITH cte AS 
(
    SELECT employee_name, city, id,
           ROW_NUMBER() OVER (PARTITION BY employee_name, city ORDER BY employee_name DESC) AS Rwn
    FROM Employee
)

SELECT * FROM cte WHERE Rwn > 1
--For Deleteing Duplicates Record  --Delete from cte where rwn>1



	
----Query for Getting All Records that has some Duplicates Records also -------
WITH cte AS 
(
    SELECT employee_name, city, id,
           ROW_NUMBER() OVER (PARTITION BY employee_name, city ORDER BY employee_name DESC) AS Rwn
    FROM Employee
)

SELECT Emp.* FROM Employee Emp
INNER JOIN cte  Ct ON Emp.employee_name = ct.employee_name AND Emp.city = Ct.City
WHERE Rwn > 1
order by Employee_Name

----------------------------------Thanks------------------------------------------ 

	
-----------------Willing to learn sql then Join us ------------------
Follow me in insta :: https://www.instagram.com/sqlholic/
Subscribe to our youtube channel :: https://www.youtube.com/@sqlholic



