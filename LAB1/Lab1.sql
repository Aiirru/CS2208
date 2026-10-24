DROP TABLE IF EXISTS BRANCH;
DROP TABLE IF EXISTS STAFF;
DROP TABLE IF EXISTS PROPERTY;
DROP TABLE IF EXISTS RENTER;
DROP TABLE IF EXISTS OWNER;
DROP TABLE IF EXISTS VIEWING;


CREATE TABLE BRANCH (
    BranchNo VARCHAR(3) PRIMARY KEY,
    Street VARCHAR(100),
    Area VARCHAR(50),
    City VARCHAR(50),
    TelNo VARCHAR(20)
);

CREATE TABLE STAFF (
	StaffNo INT PRIMARY KEY,
	FName VARCHAR(20),
	LName VARCHAR(20),
	Address VARCHAR(100),
	TelNo VARCHAR(20),
	Job VARCHAR(40),
	Gender CHAR(20),
	Salary DECIMAL(20,2),
	BranchNo VARCHAR(3)
);

CREATE TABLE PROPERTY (
	PropertyNo INT PRIMARY KEY,
	Street VARCHAR(100),
	Area VARCHAR(50),
	City VARCHAR(50),
	Type VARCHAR(20),
	Rooms INT,
	Rent DECIMAL(10,2),
	OwnerNo INT,
	StaffNo INT,
	BranchNo VARCHAR(3)
);

CREATE TABLE RENTER (
	RenterNo INT PRIMARY KEY,
	FName VARCHAR(20),
	LName VARCHAR(20),
	Address VARCHAR(100),
	TelNo VARCHAR(20),
	TypePreference VARCHAR(20),
	MaxRent DECIMAL(7,2)
);

CREATE TABLE OWNER (
	OwnerNo INT PRIMARY KEY,
	FName VARCHAR(20),
	LName VARCHAR(20),
	Address VARCHAR(100),
	TelNo VARCHAR(20)
);

CREATE TABLE VIEWING (
	RenterNo INT,
	PropertyNo INT,
	Date DATE,
	Comment VARCHAR(100)
);


-- Insert into BRANCH
INSERT INTO BRANCH (BranchNo, Street, Area, City, TelNo) VALUES
('B1', 'College Road', 'UCC', 'Cork City', '021-4903000'),
('B2', 'Patrick Street', 'Town Centre', 'Fermoy', '025-31234'),
('B3', 'Oliver Plunkett Street', 'City Centre', 'Cork City', '021-4271122'),
('B4', 'Washington Street', 'City Centre', 'Cork City', '021-4275566'),
('B5', 'Douglas Road', 'Douglas', 'Cork City', '021-4891234');

-- Insert into STAFF
INSERT INTO STAFF (StaffNo, FName, LName, Address, TelNo, Job, Gender, Salary, BranchNo) VALUES
(1, 'Liam', 'O Connor', '12 Western Road, Cork City', '087-1234567', 'Manager', 'M', 52000.00, 'B1'),
(2, 'Aoife', 'Murphy', '45 Main Street, Fermoy', '', 'Senior Agent', 'F', 44000.00, 'B2'),
(3, 'Ciaran', 'Walsh', '8 Donovans Road, UCC, Cork City', '085-5551234', 'Assistant', 'M', 18000.00, 'B3'),
(4, 'Tommy', 'Walsh', '8 Donovans Road, UCC, Cork City', '085-5551234', 'Assistant', 'M', 18000.00, 'B3');

-- Insert into OWNER
INSERT INTO OWNER (OwnerNo, FName, LName, Address, TelNo) VALUES
(1, 'Seán', 'McCarthy', 'Wilton Road, Cork City', '087-2345678'),
(2, 'Brid', 'O Sullivan', 'Dublin Road, Fermoy', '086-8765432');

-- Insert into RENTER
INSERT INTO RENTER (RenterNo, FName, LName, Address, TelNo, TypePreference, MaxRent) VALUES
(1, 'Conor', 'Flynn', 'Victoria Cross, Cork City', '087-3456789', 'Apartment', 1600.00),
(2, 'Sinead', 'Lynch', 'Pearse Square, Fermoy', '086-7654321', 'House', 1400.00);
(5, 'Conor', 'Ryan', 'Victoria Cross, Cork City', '087-3456789', 'Apartment', 1600.00),

-- Insert into PROPERTY
INSERT INTO PROPERTY (PropertyNo, Street, Area, City, Type, Rooms, Rent, OwnerNo, StaffNo, BranchNo) VALUES
(1, '14 College Road', 'UCC', 'Cork City', 'Apartment', 3, 1500.00, 1, 1, 'B1'),
(2, '2 North Main Street', 'Town Centre', 'Fermoy', 'House', 3, 460.00, 2, 2, 'B2'),
(3, '22 Gillabbey Street', 'UCC', 'Cork City', 'House', 5, 2200.00, 1, 3, 'B3'),
(4, '3 North Main Street', 'Town Centre', 'Fermoy', 'House', 3, 470.00, 2, 2, 'B2');

-- Insert into VIEWING
INSERT INTO VIEWING (RenterNo, PropertyNo, Date, Comment) VALUES
(1, 1, '2026-09-20', 'Ideal location right across from UCC main gate.'),
(5, 3, '2026-09-22', 'Spacious, but rent is slightly over budget.'),
(2, 2, '2026-09-24', 'Quite Damp.');



--ANSWERS 
--Question 1
SELECT FName, LName, Address, Salary FROM STAFF WHERE Gender = 'M' AND Salary < 20000;

--Question 2
SELECT * FROM STAFF WHERE Gender = 'F' AND TelNo = '';

--Question 3
SELECT PropertyNo, Street, Area, City FROM PROPERTY WHERE BranchNo = 'B3' AND ((Type = 'Apartment' AND Rooms > '3') OR Type = 'House') ;

--Question 4
SELECT Street, Area, City, Rent FROM PROPERTY WHERE BranchNo = 'B2' AND Rooms = '3' AND Rent BETWEEN 400 AND 500 ORDER BY Rent DESC;

--Question 5
SELECT DISTINCT R.FName, R.LName FROM RENTER as R JOIN VIEWING as V ON R.RenterNo = V.RenterNo WHERE V.Comment LIKE '%damp%';

--Question 6
SELECT StaffNo  FROM STAFF WHERE StaffNo NOT IN (SELECT DISTINCT StaffNo FROM PROPERTY WHERE StaffNo IS NOT NULL
);

--Question 7
SELECT DISTINCT PropertyNo FROM VIEWING WHERE PropertyNo IS NOT NULL;

--Question 8
SELECT O.FName, O.LName, O.TelNo FROM OWNER as O JOIN PROPERTY as P ON O.OwnerNo = P.OwnerNo GROUP BY O.OwnerNo, O.FName, O.LName, O.TelNo HAVING COUNT(P.PropertyNo) > 1;
