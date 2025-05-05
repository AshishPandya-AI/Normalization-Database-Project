
# 🧱 Employee Database Normalization Project – 3NF with SQL & Python

This project demonstrates the full normalization process of a complex employee dataset—from **0NF to 3NF**, implemented through **Excel**, **SQL scripts**, and **Python integration with ML Services**. The objective is to design a scalable, consistent, and efficient **relational database schema** following **best database design practices** and **real-world query applications**.

---

## 📌 Project Overview

- **Project Name**: Employee Normalization & SQL Query System
- **Student Name**: Ashish Pandya  
- **Course**: Enterprise Data Architecture  
- **Date**: March 12, 2025
- **Tools Used**: MS Excel, MS SQL Server, Python, SSMS, ERD Designer

---

## 🧠 Goal of the Project

- Remove redundancy and inconsistency from unnormalized data
- Restructure and normalize data up to **Third Normal Form (3NF)**
- Create **relational tables with keys & constraints**
- Implement **complex SQL queries** and **Python-based ML Services**
- Generate **ERD with Crow's Foot Notation**
- Solve practical **business queries**

---

## 🧪 Normalization Stages

### 🔴 0NF (Unnormalized Form)
- Contains multi-valued & repeating groups
- Embedded payroll and committee data in single rows
- Derived attribute: `Person Hours Worked`

---

### 🟠 1NF (First Normal Form)
- Atomic values only
- Introduced **Committees** table
- Separated many-to-many relationships via `Employee_Committees`

**Tables Created:**
- `Employees (EmpId)`
- `Jobs (JobCode)`
- `Committees (CommitteeId)`
- `Employee_Committees (EmpId, CommitteeId)`

---

### 🟡 2NF (Second Normal Form)
- Removed partial dependencies
- Created `Payroll`, `Supervisors`, and `Supervision` tables

**Tables Added:**
- `Payroll (PayrollId, EmpId)`
- `Supervisors (SupervisorId)`
- `Supervision (EmpId, SupervisorId)`

---

### 🟢 3NF (Third Normal Form)
- Removed transitive dependencies
- Dropped derived fields like `Person Hours Worked`
- Final schema ensures **referential integrity**

---

## ✅ Final Tables at 3NF

| Table                 | Description                                 |
|----------------------|---------------------------------------------|
| `Employees`          | Basic employee info                         |
| `Jobs`               | Job titles and pay rates                    |
| `Payroll`            | Pay period data, hours, and overtime        |
| `Supervisors`        | Info on all managers                        |
| `Supervision`        | Mapping employees to supervisors            |
| `Committees`         | Committees available in the org            |
| `Employee_Committees`| Links employees to multiple committees      |

---

## 📉 Crow's Foot ERD Notation

The project includes a detailed **ERD (Entity Relationship Diagram)** with:
- Primary and Foreign Keys
- 1-to-Many and Many-to-Many relationships
- Clear entity attributes and references

📎 *Diagram available in the folder: `Crowfoot_Notation_ERD.png`*

---

## 🧮 SQL Query Solutions (Real-World Scenarios)

1. **Find employees who worked > 25 hours** and have 's' in their last name
2. **Given EmpID**, fetch job code, manager name, and contact
3. **List of members** in ‘OH&S’ committee with job descriptions
4. **Find employees** managed by a supervisor with last name 'Muktadir'
5. **Create a VIEW** showing committee, employee, and supervisor info (filter: Meeting Night = 'Tues')
6. **Calculate years of service** per employee
7. **Bar graph**: Supervisor vs No. of employees using `sp_execute_external_script`
8. **Calculate earnings in USD** using Python & `sp_execute_external_script`

---

## 🧠 ML Integration (MS SQL + Python)

Two queries implement **external Python scripts** using:
```sql
EXEC sp_execute_external_script
```
To:
- Convert earnings from CAD to USD
- Generate bar plots from query results

---

## 🧾 Attribute Descriptions & Notes

| Attribute            | Notes                                                                 |
|----------------------|------------------------------------------------------------------------|
| `Person Hours Worked`| Removed – derived attribute (Hours + Overtime)                        |
| `Supervisor`         | Split into separate table and link table                              |
| `Committees`         | Many-to-many relationship properly modeled                            |
| `Payroll`            | Now normalized and scalable per pay period                            |
| `JobCode`            | De-duplicated using a separate Job table                              |

---

## 💬 Key Challenges Addressed

| Challenge                                   | Solution                                                                 |
|--------------------------------------------|--------------------------------------------------------------------------|
| Repeating committee fields in one column   | Separated via `Employee_Committees` table                                |
| Supervisor managing multiple departments   | Introduced `Supervisors` + `Supervision`                                 |
| Payroll data embedded in employee rows     | Created normalized `Payroll` table                                       |
| Derived column stored (`Person Hours`)     | Removed and calculated via SQL                                           |

---

## 📂 Folder Structure

```
Normalization-Database-Project/
│
├── SQL_Scripts/
│   └── all_queries.sql
│
├── Excel_Design/
│   └── Normalization_Excel_File_Ashish_Pandya.xlsx
│
├── ERD_Diagram/
│   └── Crowfoot_Notation_ERD.png
│
├── README.md
└── .gitignore
```

---

## 🧑‍💻 Author

**Ashish Pandya**  
📘 Enterprise Data Architecture  
📍 Regina, SK, Canada  
🔗 GitHub: [AshishPandya-AI](https://github.com/AshishPandya-AI)

---

## 📚 References

- Elmasri, R., & Navathe, S. (2020). *Fundamentals of Database Systems* (7th ed.)
- Connolly, T., & Begg, C. (2015). *Database Systems* (6th ed.)

---

## 📃 License

This project is licensed under the MIT License for academic and educational use.
