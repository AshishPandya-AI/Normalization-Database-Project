-- Q1: Find employees working >25 hours and whose last name contains 's'.
SELECT p.EmpId, 
       e.LastName + ' ' + e.FirstName AS 'Full Name', 
       s.SupervisorName, 
       p.Hours
FROM Payroll p
JOIN Employees e ON p.EmpId = e.EmpId
JOIN Supervision sp ON e.EmpId = sp.EmpId
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
WHERE p.Hours > 25
AND e.LastName LIKE '%s%';

-- Q2: Get job code, manager’s name, and cell number for a given Employee ID.
DECLARE @EmployeeID INT = 72262;  

SELECT DISTINCT e.EmpId, e.JobCode, s.SupervisorName, s.SupervisorCell
FROM Employees e
JOIN Supervision sp ON e.EmpId = sp.EmpId
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
WHERE e.EmpId = @EmployeeID;

--Q3: Get employees and their job description for a given committee (e.g., "OH&S").
SELECT e.EmpId, 
       e.FirstName + ' ' + e.LastName AS 'Full Name', 
       j.Position
FROM Employee_Committees ec
JOIN Employees e ON ec.EmpId = e.EmpId
JOIN Jobs j ON e.JobCode = j.JobCode
JOIN Committees c ON ec.CommitteeId = c.CommitteeId
WHERE c.CommitteeName = 'OH&S';

--Q4: Find employees under a given supervisor’s last name.
DECLARE @SupervisorLastName VARCHAR(50) = 'Muktadir'; 

SELECT DISTINCT e.EmpId, 
       e.FirstName + ' ' + e.LastName AS 'Full Name', 
       e.JobCode
FROM Employees e
JOIN Supervision sp ON e.EmpId = sp.EmpId
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
WHERE s.SupervisorName LIKE '%' + @SupervisorLastName + '%';

--Q5: Create a view for employees in committees meeting on "Tues".
SELECT DISTINCT e.EmpId, 
       e.FirstName + ' ' + e.LastName AS 'Full Name', 
       ec.CommitteeId, 
       c.MeetingNight, 
       c.CommitteeName, 
       s.SupervisorId, 
       s.SupervisorName
FROM Employee_Committees ec
JOIN Employees e ON ec.EmpId = e.EmpId
JOIN Committees c ON ec.CommitteeId = c.CommitteeId
JOIN Supervision sp ON e.EmpId = sp.EmpId
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
WHERE c.MeetingNight = 'Tues';


-- Q6: Calculate years worked for each employee.
SELECT e.EmpId, 
       e.FirstName + ' ' + e.LastName AS 'Full Name',
       DATEDIFF(YEAR, p.HireDate, GETDATE()) AS 'Years Worked'
FROM Employees e
JOIN Payroll p ON e.EmpId = p.EmpId;


--Q7: Count employees under each supervisor and generate a bar graph using Python & ML Services.

SELECT s.SupervisorName, COUNT(sp.EmpId) AS 'Number_of_Employees'
FROM Supervision sp
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
GROUP BY s.SupervisorName;

EXEC sp_execute_external_script  
@language = N'Python',  
@script = N'
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt

# Use Agg backend to avoid GUI errors
matplotlib.use("Agg")  

# Convert SQL data to DataFrame
df = InputDataSet

# Check if data exists
if df.empty:
    print("No data available for visualization.")
else:
    # Plot bar graph
    plt.figure(figsize=(8,5))
    plt.bar(df["SupervisorName"], df["Number_of_Employees"])
    plt.xlabel("Supervisor Name")
    plt.ylabel("Number of Employees")
    plt.title("Employees Managed by Each Supervisor")
    plt.xticks(rotation=45)

    # Save chart with a corrected path
    plt.savefig(r"C:\ProgramData\MSSQLSERVER\Temp-PY\Appcontainer1\Supervisor_Employees_BarChart.png")
    print("Bar chart saved successfully!")
',
@input_data_1 = N'
SELECT s.SupervisorName, COUNT(sp.EmpId) AS Number_of_Employees 
FROM Supervision sp
JOIN Supervisors s ON sp.SupervisorId = s.SupervisorId
GROUP BY s.SupervisorName';

--Q8 Calculate Total Earnings in CAD
DROP TABLE IF EXISTS #Temp_Earnings;

SELECT e.EmpId, 
       e.FirstName + ' ' + e.LastName AS 'Full Name', 
       CAST(SUM(p.Hours + p.OT) AS FLOAT) AS 'Total Hours Worked',  -- Convert to FLOAT
       CAST(j.Payrate * SUM(p.Hours + p.OT) AS FLOAT) AS 'Total Earnings (CAD)'  -- Convert to FLOAT
INTO #Temp_Earnings
FROM Payroll p
JOIN Employees e ON p.EmpId = e.EmpId
JOIN Jobs j ON e.JobCode = j.JobCode
GROUP BY e.EmpId, e.FirstName, e.LastName, j.Payrate;

-- Check the Data
SELECT * FROM #Temp_Earnings;


-- Convert CAD Earnings to USD using Python Script
EXEC sp_execute_external_script  
@language = N'Python',  
@script = N'
import pandas as pd

# Define exchange rate (example: 1 CAD = 0.75 USD)
exchange_rate = 0.75
df = InputDataSet
# Convert to USD
df["Total Earnings (USD)"] = df["Total Earnings (CAD)"] * exchange_rate

# Output data
OutputDataSet = df[["Full Name", "Total Earnings (USD)"]]
',
@input_data_1 = N'SELECT * FROM #Temp_Earnings',
@output_data_1_name = N'OutputDataSet';


