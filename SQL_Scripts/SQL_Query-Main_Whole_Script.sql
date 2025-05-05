-- Create Database
CREATE DATABASE AshishPandya;

-- Create Jobs Table First
CREATE TABLE Jobs (
    JobCode INT PRIMARY KEY,
    Position VARCHAR(50),
    Payrate DECIMAL(10,2)
);

-- Create Employees Table
CREATE TABLE Employees (
    EmpId INT PRIMARY KEY,
    SIN VARCHAR(15) UNIQUE NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Street VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(10),
    PostalCode VARCHAR(10),
    JobCode INT,
    FOREIGN KEY (JobCode) REFERENCES Jobs(JobCode)
);

CREATE TABLE Payroll (
    PayrollId INT PRIMARY KEY,
    EmpId INT,
    PayWeekEnd DATE,
    DaysAvailable INT,
    Hours DECIMAL(5,2),
    OT DECIMAL(5,2),
    HireDate DATE,  
    FOREIGN KEY (EmpId) REFERENCES Employees(EmpId),
);


-- Supervisors Table
CREATE TABLE Supervisors (
    SupervisorId INT PRIMARY KEY,
    SupervisorName VARCHAR(100),
    SupervisorCell VARCHAR(15)
);

-- Supervision Table
CREATE TABLE Supervision (
    EmpId INT,
    SupervisorId INT,
    PRIMARY KEY (EmpId, SupervisorId),
    FOREIGN KEY (EmpId) REFERENCES Employees(EmpId),
    FOREIGN KEY (SupervisorId) REFERENCES Supervisors(SupervisorId)
);

-- Committees Table
CREATE TABLE Committees (
    CommitteeId INT PRIMARY KEY,
    CommitteeName VARCHAR(100) UNIQUE,
    MeetingNight VARCHAR(10) 
);


-- Employee_Committees Table (Many-to-Many Relationship)
CREATE TABLE Employee_Committees (
    EmpId INT,
    CommitteeId INT,
    PRIMARY KEY (EmpId, CommitteeId),
    FOREIGN KEY (EmpId) REFERENCES Employees(EmpId),
    FOREIGN KEY (CommitteeId) REFERENCES Committees(CommitteeId)
);

-- Insert Data into Jobs Table
INSERT INTO Jobs (JobCode, Position, Payrate) VALUES
(3000, 'Stockperson', 12.99),
(5000, 'Butcher', 18),
(2000, 'Cashier', 11.99),
(1000, 'Greeter', 10.25),
(7000, 'Pharmacist', 30),
(8000, 'Assistant Baker', 15.5),
(4000, 'Baker', 17.5),
(6000, 'Cleaner', 13.5),
(9000, 'Security Guard', 9.99);

-- Insert Data into Supervisors Table
INSERT INTO Supervisors (SupervisorId, SupervisorName, SupervisorCell) VALUES
(1, 'Abu Muktadir', '306.304.4545'),
(2, 'Joseph Herbert', '306.304.1212'),
(3, 'Roger Federer', '306.304.4100'),
(4, 'Melissa Jones', '306.304.8878'),
(5, 'James Snowdale', '306.304.9091');

-- Insert Data into Committees Table
INSERT INTO Committees (CommitteeId, CommitteeName, MeetingNight) VALUES
(1, 'OH&S', 'Fri'),
(2, 'Party Committee', 'Wed'),
(3, 'Social Res. Com.', 'Mon');


-- Insert Data into Employees Table
INSERT INTO Employees (EmpId, SIN, FirstName, LastName, Street, City, Province, PostalCode, JobCode) VALUES
(97319, '516303417', 'Gerry', 'Novak', '6803 Park Ave.', 'Moose Jaw', 'SK', 'S6H 1X7', 3000),
(33982, '867481381', 'Robin', 'Boychuk', '117 East Broadway', 'Moose Jaw', 'SK', 'S6H 3P5', 5000),
(51537, '112893584', 'Kim', 'Smith', '9745 University Drive', 'Regina', 'SK', 'S4P 7A3', 2000),
(41822, '717505366', 'Chris', 'Miller', '72 Railway Ave.', 'Pense', 'SK', 'S0T 1K4', 2000),
(3571, '374853129', 'Jo', 'Hashimoto', '386 High Street', 'Tuxford', 'SK', 'S0L 8V6', 1000),
(85833, '466128562', 'Lindsey', 'Singh', '1216 Willow Cres.', 'Pasqua', 'SK', 'S0H 5T8', 7000),
(81216, '615917448', 'Jaimie', 'Hansen', '95 Lakeshore Blvd.', 'Caronport', 'SK', 'S0T 3S7', 8000),
(32177, '306114858', 'Robbie', 'DaSilva', '4319 Main St.', 'Moose Jaw', 'SK', 'S6H 2M2', 4000),
(52421, '936654021', 'Shelley', 'O''Day', '27 High St.', 'Tuxford', 'SK', 'S0L 8V6', 6000),
(72690, '655971502', 'Jodie', 'Wong', '59 Oslo Square', 'Moose Jaw', 'SK', 'S6H 2H9', 6000),
(72201, '635111876', 'Kelly', 'Ramirez', '1015 Brunswick Lane', 'Moose Jaw', 'SK', 'S6H 4T5', 3000),
(72262, '635666150', 'Rafael', 'Nadal', '1025 Pasqua St.', 'Regina', 'SK', 'S4S 2H4', 9000);

INSERT INTO Payroll (PayrollId, EmpId, PayWeekEnd, DaysAvailable, Hours, OT, HireDate) VALUES
(1,  97319, '2013-05-23', 7, 40, 0, '2003-07-07'),
(2,  33982, '2013-05-23', 7, 40, 0, '1998-10-11'),
(3,  51537, '2013-05-23', 7, 27, 0, '2001-12-02'),
(4,  41822, '2013-05-23', 7, 40, 0, '1985-02-19'),
(5,  3571,  '2013-05-23', 7, 40, 0.5, '1980-03-20'),
(6,  85833, '2013-05-23', 7, 37.5, 0, '2002-07-27'),
(7,  81216, '2013-05-23', 7, 40, 3.7, '2002-05-21'),
(8,  32177, '2013-05-23', 7, 40, 0, '1983-07-07'),
(9,  52421, '2013-05-23', 7, 22, 0, '1997-11-08'),
(10, 72690, '2013-05-23', 7, 36, 0, '2003-08-26'),
(11, 72201, '2013-05-30', 6, 18, 0, '2013-05-30'),
(12, 72262, '2013-05-30', 6, 18, 0, '2022-08-26');

--Insert Data into Supervivion table
INSERT INTO Supervision (EmpId, SupervisorId) VALUES
(97319, 1),
(33982, 2),
(51537, 4),
(41822, 4),
(3571,  4),
(85833, 5),
(81216, 2),
(32177, 2),
(52421, 1),
(72690, 1),
(72201, 1),
(72262, 3);

--Insert data into Employess_Committees table
INSERT INTO Employee_Committees (EmpId, CommitteeId) VALUES
(97319, 1),
(72201, 1),
(33982, 1),
(32177, 1),
(72690, 2),
(51537, 2),
(81216, 2),
(41822, 2),
(41822, 3),
(32177, 3),
(72690, 3),
(97319, 3);

