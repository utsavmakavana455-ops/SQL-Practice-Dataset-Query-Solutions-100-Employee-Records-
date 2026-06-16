



           --  1:- Highest-paid employee
SELECT *
FROM Employees
ORDER BY Salary DESC
LIMIT 1;

                   -- 2. Second-highest salary

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

					-- 3. Average salary by department
SELECT Department,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;


					-- 4. Count employees in each department
SELECT Department,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;

					-- 5. Employees hired after 2021-01-01
SELECT *
FROM Employees
WHERE HireDate > '2021-01-01';


					-- 6. Top 10 highest salaries
SELECT *
FROM Employees
ORDER BY Salary DESC
LIMIT 10;


				-- 7. Employees earning above company average salary
SELECT *
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);


				-- 8. Department with the highest average salary
                
SELECT Department,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
ORDER BY AvgSalary DESC
LIMIT 1;

					-- 9. Rank employees by salary within each department
SELECT EmployeeID,
       Name,
       Department,
       Salary,
       RANK() OVER
       (
           PARTITION BY Department
           ORDER BY Salary DESC
       ) AS SalaryRank
FROM Employees;


					-- 10. Employees earning between 70,000 and 85,000
SELECT *
FROM Employees
WHERE Salary BETWEEN 70000 AND 85000;


				-- 11. Find duplicate salaries

SELECT Salary,
       COUNT(*) AS CountSalary
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1;

				-- 12. Find employees with the same salary
                
SELECT e1.Name,
       e1.Salary
FROM Employees e1
WHERE e1.Salary IN
(
    SELECT Salary
    FROM Employees
    GROUP BY Salary
    HAVING COUNT(*) > 1
);

				-- 13. Third-highest salary

SELECT DISTINCT Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 1 OFFSET 2;

						-- 14. Employees earning more than department average
SELECT e.*
FROM Employees e
JOIN
(
    SELECT Department,
           AVG(Salary) AvgSalary
    FROM Employees
    GROUP BY Department
) d
ON e.Department = d.Department
WHERE e.Salary > d.AvgSalary;


				-- 15. Running total of salaries
SELECT EmployeeID,
       Name,
       Salary,
       SUM(Salary) OVER
       (
           ORDER BY EmployeeID
       ) AS RunningTotal
FROM Employees;

						-- 16. Highest-paid employee in each department

SELECT *
FROM Employees e
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Employees
    WHERE Department = e.Department
);

					-- 17. Lowest-paid employee in each department

SELECT *
FROM Employees e
WHERE Salary =
(
    SELECT MIN(Salary)
    FROM Employees
    WHERE Department = e.Department
);
					-- 18. Department salary totals

SELECT Department,
       SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

						-- 19. Employees hired in the latest year

SELECT *
FROM Employees
WHERE YEAR(HireDate) =
(
    SELECT MAX(YEAR(HireDate))
    FROM Employees
);