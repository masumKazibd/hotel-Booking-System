/*

							SQL Project Name : Hotel Booking System(HBS)
										Trainee Name : Md. Masum Kazi   
						    			  Trainee ID : 1279032       
									Batch ID : WADA/PNTL-A/56/1 
__________________________________________________________________________________________

Table of Contents: DML

			SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
			SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
					--- 3.1 : UPDATE DATA THROUGH STORED PROCEDURE
					--- 3.2 : DELETE DATA THROUGH STORED PROCEDURE
					--- 3.3 : STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR
			SECTION 04: INSERT UPDATE DELETE DATA THROUGH VIEW
					--- 4.1 : INSERT DATA through view
					--- 4.2 : UPDATE DATA through view
					--- 4.3 : DELETE DATA through view
			SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			SECTION 07: QUERY
					--- 7.01 A SELECT STATEMENT TO GET RESULT-SET FROM A TABLE 
					--- 7.02 A SELECT STATEMENT TO GET Guest information FROM A VIEW 
					--- 7.03 [ SELECT INTO ] SAVE RESULT SET TO A NEW TEMPORARY TABLE
					--- 7.04 IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
					--- 7.05 INNER JOIN WITH GROUP BY CLAUSE 
					--- 7.06 OUTER JOIN
					--- 7.07 CROSS JOIN
					--- 7.08 TOP CLAUSE WITH TIES
					--- 7.09 DISTINCT
					--- 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR 
					--- 7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE 
					--- 7.12 OFFSET FETCH 
					--- 7.13 UNION 
					--- 7.14 EXCEPT INTERSECT
					--- 7.15 AGGREGATE FUNCTION
					--- 7.16 AGGREGATE FUNCTION WITH GROUP BY & HAVING CLAUSE
					--- 7.17 ROLLUP & CUBE OPERATOR
					--- 7.18 GROUPING SETS 
					--- 7.19 SUB-QUERIES
					--- 7.20 EXISTS 
					--- 7.21 CTE 
					--- 7.22 BUILT IN FUNCTION 
					--- 7.23 CASE 
					--- 7.24 IIF 
					--- 7.25 COALESCE & ISNULL 
					--- 7.26 WHILE 
					--- 7.27 RANKING FUNCTION 
					--- 7.28 IF ELSE & PRINT 
					--- 7.29 TRY CATCH 
					--- 7.30 GOTO 
					--- 7.31 WAITFOR 
					--- 7.32 SYSTEM STORED PROCEDURE(sp_helptext) TO GET UNENCRYPTED STORED PROCEDURE SCRIPT  

								______________________________*/

/*______________________________ SECTION 01 
					INSERT DATA USING INSERT INTO KEYWORD
								______________________________*/


USE HBS
GO

INSERT INTO Room_Types (Room_Type_ID, Room_Type_Name, Room_Type_Description, Room_Type_Capacity, Room_Type_Price)
VALUES
    (1, 'Standard Single', 'A comfortable room for single occupancy', 1, 100.00),
    (2, 'Standard Double', 'A cozy room for double occupancy', 2, 150.00),
    (3, 'Deluxe Single', 'A luxurious room for single occupancy', 1, 200.00),
    (4, 'Deluxe Double', 'A lavish room for double occupancy', 2, 250.00),
    (5, 'Executive Suite', 'A spacious suite for business travelers', 2, 300.00),
    (6, 'Family Suite', 'A family-friendly suite with extra amenities', 4, 350.00),
    (7, 'Honeymoon Suite', 'A romantic suite for newlyweds', 2, 400.00),
    (8, 'Presidential Suite', 'An opulent suite for VIP guests', 4, 500.00),
    (9, 'Accessible Room', 'A room designed for guests with disabilities', 2, 175.00),
    (10, 'Penthouse Suite', 'The luxurious suite on the top floor', 2, 600.00);
GO

INSERT INTO Rooms (Room_Number, Room_Type_ID, Floor_ID, Room_Status)
VALUES
    (101, 1, 1, 'Vacant'),
    (102, 1, 1, 'Occupied'),
    (103, 2, 1, 'Vacant'),
    (104, 2, 1, 'Under Maintenance'),
    (201, 3, 2, 'Occupied'),
    (202, 3, 2, 'Vacant'),
    (203, 4, 2, 'Vacant'),
    (204, 4, 2, 'Vacant'),
    (301, 5, 3, 'Occupied'),
    (302, 5, 3, 'Vacant');
GO

INSERT INTO Guests ([First Name], [Last Name], Guest_Address, Guest_City, Guest_Country, DOB, Email, [Mobile No.])
VALUES
    ('Sarah', 'Miller', '3333 Maple Drive', 'Miami', 'USA', '1988-12-06', 'sarah.miller@example.com', '555-777-8888'),
    ('Matthew', 'Wilson', '4444 Pine Road', 'Seattle', 'USA', '1993-02-14', 'matthew.wilson@example.com', '555-999-0000'),
    ('Jessica', 'Taylor', '5555 Birch Lane', 'Boston', 'USA', '1980-04-30', 'jessica.taylor@example.com', '555-222-3333'),
    ('Daniel', 'Anderson', '6666 Cedar Street', 'Dallas', 'USA', '1991-08-20', 'daniel.anderson@example.com', '555-444-5555'),
    ('Laura', 'Thomas', '7777 Willow Court', 'Washington D.C.', 'USA', '1996-01-09', 'laura.thomas@example.com', '555-666-7777');
GO

INSERT INTO Bookings (Booking_ID, Guest_ID, Room_Number, Room_Type_ID, Check_In_Date, Check_Out_Date, Kids_Number, Booking_Status)
VALUES
    (1, 1, 101, 1, '2023-07-30', '2023-08-05', 0, 'Confirmed'),
    (2, 2, 102, 1, '2023-08-02', '2023-08-07', 1, 'Confirmed'),
    (3, 3, 103, 2, '2023-08-10', '2023-08-15', 2, 'Confirmed'),
    (4, 4, 104, 2, '2023-08-20', '2023-08-25', 0, 'Confirmed'),
    (5, 5, 201, 3, '2023-09-01', '2023-09-05', 1, 'Confirmed'),
    (6, 6, 202, 3, '2023-09-05', '2023-09-10', 2, 'Confirmed'),
    (7, 7, 203, 4, '2023-09-12', '2023-09-17', 0, 'Confirmed'),
    (8, 8, 204, 4, '2023-09-20', '2023-09-25', 0, 'Confirmed'),
    (9, 9, 301, 5, '2023-10-01', '2023-10-05', 2, 'Confirmed'),
    (10, 10, 302, 5, '2023-10-03', '2023-10-07', 1, 'Confirmed'),
	(11, 1, 203, 4, '2023-09-12', '2023-09-17', 0, 'Confirmed'),
    (12, 2, 104, 4, '2023-09-20', '2023-09-25', 0, 'Confirmed'),
    (13, 5, 201, 5, '2023-10-01', '2023-10-05', 2, 'Confirmed'),
    (14, 3, 203, 5, '2023-10-03', '2023-10-07', 1, 'Confirmed');
GO


INSERT INTO Payments (Payment_ID, Booking_ID, Payment_Date, Payment_Method, Amount)
VALUES
    (1, 1, '2023-08-01 10:30:00', 'Credit Card', 200.00),
    (2, 2, '2023-08-03 14:15:00', 'Cash', 180.50),
    (3, 3, '2023-08-12 11:00:00', 'Debit Card', 300.00),
    (4, 4, '2023-08-22 09:45:00', 'Credit Card', 250.00),
    (5, 5, '2023-09-02 13:20:00', 'Cash', 180.00),
    (6, 6, '2023-09-07 16:00:00', 'Credit Card', 320.75),
    (7, 7, '2023-09-15 08:45:00', 'Debit Card', 150.00),
    (8, 8, '2023-09-23 12:30:00', 'Cash', 200.00),
    (9, 9, '2023-10-03 09:00:00', 'Credit Card', 280.50),
    (10, 10, '2023-10-05 11:15:00', 'Debit Card', 190.00);
GO

INSERT INTO Countries (Country)
VALUES
    ('United States'),
    ('Canada'),
    ('United Kingdom'),
    ('Germany'),
    ('France'),
    ('Australia'),
    ('Japan'),
    ('China'),
    ('India'),
    ('Brazil');
GO


/*______________________________SECTION 02 
					INSERT DATA THROUGH STORED PROCEDURE
								______________________________*/

EXEC AddGuest 'John', 'Doe', '1990-05-15', 'john.doe@example.com', '555-123-4567', '123 Main Street', 'New York', 'USA';
EXEC AddGuest 'Jane', 'Smith', '1985-11-22', 'jane.smith@example.com', '555-987-6543', '456 Park Avenue', 'Los Angeles', 'USA';
EXEC AddGuest 'Michael', 'Johnson', '1982-07-10', 'michael.johnson@example.com', '555-111-2222', '789 Broadway', 'Chicago', 'USA';
EXEC AddGuest 'Emily', 'Williams', '1995-03-28', 'emily.williams@example.com', '555-333-4444', '1111 Elm Street', 'San Francisco', 'USA';
EXEC AddGuest 'David', 'Brown', '1998-09-17', 'david.brown@example.com', '555-555-5555', '2222 Oak Avenue', 'Houston', 'USA';



/*______________________________  SECTION 03 
			UPDATE DELETE DATA THROUGH STORED PROCEDURE
								______________________________*/


----------------- STORED PROCEDURE for update trainee (closing date & closing remarks)


EXEC UpdateRoom @Room_Number = 103, @Room_Type_ID = 2, @Floor_ID = 1, @Room_Status = 'Under Maintenance';
EXEC UpdateRoom @Room_Number = 202, @Room_Type_ID = 3, @Floor_ID = 3, @Room_Status = 'Vacant';
EXEC UpdateRoom @Room_Number = 301, @Room_Type_ID = 5, @Floor_ID = 4, @Room_Status = 'Occupied';
EXEC UpdateRoom @Room_Number = 999, @Room_Type_ID = 1, @Floor_ID = 5, @Room_Status = 'Vacant';
GO

----------------- DELETE DATA THROUGH STORED PROCEDURE 

EXEC DeleteRoom @Room_Number = 301, @Room_Type_ID = 5;
EXEC DeleteRoom @Room_Number = 999, @Room_Type_ID = 1;



/*______________________________ SECTION 04 
					INSERT UPDATE DELETE DATA THROUGH VIEW
								______________________________*/

----------------- UPDATE DATA through view 

UPDATE VW_GuestsInfo
SET [First Name] = 'Masum Kazi'
WHERE [Guest ID] = 5
GO

SELECT * FROM VW_GuestsInfo
GO

-----------------  DELETE DATA through view 
DELETE FROM VW_GuestsInfo
WHERE [Guest ID] = 5
GO

SELECT * FROM VW_GuestsInfo
GO

/*______________________________ SECTION 05 
						RETREIVE DATA USING FUNCTION
								______________________________*/

SELECT dbo.fnCurrentYearPayments() AS 'Currrent Year Net Payments'
GO

SELECT * FROM dbo.fnMonthlyPayments(2022, 6)
GO


/*______________________________  SECTION 06  
							   TEST TRIGGER
								______________________________*/

-----------------  FOR/AFTER TRIGGER ON TABLE 
-----------------  Insert data into the 'Guests' table, which will be handled by the trigger
INSERT INTO Guests ([First Name], [Last Name], Guest_Address, Guest_City, Guest_Country, DOB, Email, [Mobile No.])
VALUES
    ('John', 'Doe', '123 Main Street', 'New York', 'USA', '1990-05-15', 'john.doe@example.com', '555-123-4567'),
    ('Jane', 'Smith', '456 Park Avenue', 'Los Angeles', 'USA', '1985-11-22', 'jane.smith@example.com', '555-987-6543');

GO

/*______________________________  SECTION 07  
								  QUERY
									______________________________*/

-----------------  7.01 A SELECT STATEMENT TO GET RESULT-SET FROM A TABLE 

SELECT * FROM Guests
GO

----------------- 7.02 A SELECT STATEMENT TO GET Guest information FROM A VIEW 
SELECT * FROM VW_GuestsInfo
GO

----------------- 7.03 [ SELECT INTO ] SAVE RESULT SET TO A NEW TEMPORARY TABLE

SELECT * INTO #tmpGuest
FROM guests
GO

SELECT * FROM #tmpGuest
GO


----------------- 7.04 IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE

SELECT [Guest ID], [First Name], Room_Number,Kids_Number, Booking_Status
FROM guests, Bookings
WHERE Kids_Number = 2
ORDER BY [First Name] ASC, Kids_Number DESC
GO


----------------- 7.05 INNER JOIN WITH GROUP BY CLAUSE 

-- GET Room Type Wise Guest LIST

SELECT rt.Room_Type_Name, g.[Guest ID], g.[First Name], g.[Last Name]
FROM Guests g
INNER JOIN Bookings b ON g.[Guest ID] = b.Guest_ID
INNER JOIN Room_Types rt ON b.Room_Type_ID = rt.Room_Type_ID
GROUP BY rt.Room_Type_Name, g.[Guest ID], g.[First Name], g.[Last Name];
GO


----------------- 7.06 OUTER JOIN
SELECT rt.Room_Type_Name, g.[Guest ID], g.[First Name], g.[Last Name]
FROM Guests g
LEFT JOIN Bookings b ON g.[Guest ID] = b.Guest_ID
RIGHT JOIN Room_Types rt ON b.Room_Type_ID = rt.Room_Type_ID
GO

----------------- 7.07 CROSS JOIN
SELECT *
FROM Guests
CROSS JOIN Bookings;


----------------- 7.08 TOP CLAUSE WITH TIES

SELECT TOP 5 WITH TIES Guests.[Guest ID], Bookings.Booking_Status 
FROM Guests
INNER JOIN Bookings ON Bookings.Guest_ID = Guests.[Guest ID]
ORDER BY [Guest ID]
GO

----------------- 7.09 DISTINCT
SELECT DISTINCT Guests.[Guest ID], Bookings.Booking_Status 
FROM Guests
INNER JOIN Bookings ON Bookings.Guest_ID = Guests.[Guest ID]
ORDER BY [Guest ID]
GO

----------------- 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR 

SELECT * FROM Guests
WHERE [Guest ID] = 1
AND DOB BETWEEN '1996-01-01' AND '1997-12-10'
AND NOT Guest_City = 'Miami'
OR Guest_Country = 'United States'
GO

----------------- 7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE 

SELECT * FROM Guests
WHERE Guest_City LIKE '%n'
AND [Guest ID] NOT IN ('1' ,'2')
GO

----------------- 7.12 OFFSET FETCH 
------OFFSET 5 ROWS

SELECT * FROM Guests
ORDER BY [Guest ID]
OFFSET 5 ROWS
GO

--- OFFSET 10 ROWS AND GET NEXT 5 ROWS

SELECT * FROM Guests
ORDER BY [Guest ID]
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY
GO

----------------- 7.13 UNION 

SELECT * FROM Guests
WHERE [Guest ID] IN ('1', '2', '3')

UNION

SELECT * FROM Guests
WHERE [Guest ID] IN ('4', '5', '6')
GO

----------------- 7.14 EXCEPT INTERSECT

-- EXCEPT
SELECT * FROM Bookings

EXCEPT

SELECT * FROM Bookings
WHERE Bookings.Guest_ID = 2
GO

--INTERSECT

SELECT * FROM Bookings
WHERE Bookings.Booking_ID > 5

INTERSECT

SELECT * FROM Bookings
WHERE Bookings.Booking_ID > 10
GO

----------------- 7.15 AGGREGATE FUNCTION

SELECT	COUNT(*) 'Total Payment Count',
		SUM(Amount) 'Total Amount',
		AVG(Amount) 'Average Amount',
		MIN(Amount) 'MIN Amount'
FROM Payments
GO

----------------- 7.16 AGGREGATE FUNCTION WITH GROUP BY & HAVING CLAUSE

SELECT Guests.[Guest ID], 
		count(Bookings.Guest_ID) Total,
		SUM(Amount) 'Total' 
FROM Payments
INNER JOIN Bookings 
ON Payments.Booking_ID = Bookings.Booking_ID
INNER JOIN Guests ON Guests.[Guest ID] = Bookings.Guest_ID
GROUP BY [Guest ID]
HAVING SUM(Amount) > 500
GO

----------------- 7.17 ROLLUP & CUBE OPERATOR

--ROLLUP
SELECT  b.Room_Number, b.Room_Type_ID, SUM(Amount) AS TotalAmount
FROM Payments
INNER JOIN Bookings b ON b.Booking_ID = Payments.Booking_ID
GROUP BY ROLLUP (b.Room_Number, b.Room_Type_ID);
GO

-- CUBE
SELECT b.Room_Number, b.Room_Type_ID, SUM(Amount) AS TotalAmount
FROM Payments
INNER JOIN Bookings b ON b.Booking_ID = Payments.Booking_ID
GROUP BY CUBE (b.Room_Number, b.Room_Type_ID);



----------------- 7.18 GROUPING SETS 

SELECT b.Room_Number, b.Room_Type_ID, SUM(Amount) AS TotalAmount
FROM Payments
INNER JOIN Bookings b ON b.Booking_ID = Payments.Booking_ID
GROUP BY GROUPING SETS (
  (b.Room_Number, b.Room_Type_ID),
  (b.Room_Number),
  (b.Room_Type_ID),
  ()
);


-----------------  7.19 SUB-QUERIES
---------  A subquery to findout Guests who have not booking confirmed yet

SELECT [Guest ID], [First Name], [Last Name]
FROM Guests
WHERE [Guest ID] NOT IN (
    SELECT DISTINCT Guest_ID
    FROM Bookings
    WHERE Booking_Status = 'Confirmed'
);


-----------------  7.20 EXISTS 

SELECT [Guest ID], Guest_City, DOB, Guest_Country, email, Guest_Address FROM Guests
WHERE NOT EXISTS 
			(SELECT * FROM Payments
				WHERE Guests.[Guest ID] = Payments.Payment_ID)
GO


----------------- 7.21 CTE 

-- A CTE TO GET MAXIMUM SALES COURSE
WITH MaxPaymentCTE AS (
    SELECT
        Payment_ID,
        Booking_ID,
        Payment_Date,
        Payment_Method,
        Amount,
        ROW_NUMBER() OVER (ORDER BY Amount DESC) AS rn
    FROM
        Payments
)
SELECT
    Payment_ID,
    Booking_ID,
    Payment_Date,
    Payment_Method,
    Amount
FROM
    MaxPaymentCTE
WHERE
    rn = 1;


----------------- 7.22 BUILT IN FUNCTION 

-- Get current date and time
SELECT GETDATE()
GO

-- GET STRING LENGTH
SELECT [Guest ID], LEN(Guest_City) 'Name Length' FROM Guests

-- CONVERT DATA USING CAST()
SELECT CAST(300025 AS decimal(19,3)) AS DecimalNumber
GO

-- CONVERT DATA USING CONVERT()
DECLARE @currTime DATETIME = GETDATE()
SELECT CONVERT(VARCHAR, @currTime, 108) AS ConvertToTime
GO

-- CONVERT DATA USING TRY_CONVERT()
SELECT TRY_CONVERT(FLOAT, 'HELLO', 1) AS ReturnNull
GO

-- GET DIFFERENCE OF DATES
SELECT DATEDIFF(DAY, '2021-01-01', '2022-01-01') AS DAYinYear
GO

-- GET A MONTH NAME
SELECT DATENAME(MONTH, GETDATE()) AS 'Month'
GO




----------------- 7.23 CASE 

SELECT g.[Guest ID], 
p.Amount,
	CASE 
		WHEN (p.Amount <= 100) THEN 'Lower Amount'
		WHEN (p.Amount <= 200) THEN 'Good Amount'
		WHEN (p.Amount <= 300) THEN 'Better Amount'
		WHEN (p.Amount <= 400) THEN 'Great Amount'
END AS 'Status'
FROM Payments p
INNER JOIN Guests g ON p.Booking_ID = g.[Guest ID]
GO


----------------- 7.24 IIF 

SELECT Bookings.Booking_ID, 
p.Amount,
IIF((p.amount > 200), 'Premium Guest', 'Classic Guest') AS 'Status'
FROM Payments p
INNER JOIN Bookings ON p.Booking_ID = Bookings.Booking_ID
GO



----------------- 7.25 COALESCE & ISNULL 

SELECT COALESCE(p.Payment_Method, 'Unknown') AS [Payment Method],
SUM(p.Amount) [Total Amount]
FROM Bookings
INNER JOIN Guests g ON g.[Guest ID] = Bookings.Guest_ID
INNER JOIN Payments p ON p.Booking_ID = Bookings.Booking_ID
GROUP BY  ROLLUP (Bookings.Booking_Status, p.Payment_Method)
ORDER BY p.Payment_Method DESC
GO


----------------- 7.26 WHILE 

	DECLARE @counter int
	SET @counter = 0

	WHILE @counter < 20

	BEGIN
	  SET @counter = @counter + 1
	  INSERT INTO #tmpGuest(Guest_City, Age) 
	  VALUES((NEXT VALUE FOR [dbo].seqNum), NULL)
	END

	SELECT * FROM #tmpGuest
GO

----------------- 7.27 RANKING FUNCTION 

SELECT 
RANK() OVER(ORDER BY Payment_ID) AS 'Rank',
DENSE_RANK() OVER(ORDER BY Booking_ID) AS 'Dense_Rank',
NTILE(3) OVER(ORDER BY Amount) AS 'NTILE',
Payment_ID,
Booking_ID, 
Amount
FROM Payments
GO

----------------- 7.28 IF ELSE & PRINT 
 

DECLARE @totalPayments MONEY
SELECT @totalPayments = SUM((Amount))
FROM Payments
WHERE YEAR(Payments.Payment_Date) = YEAR(GETDATE())
IF @totalPayments > 1000
	BEGIN
		PRINT 'Great ! The Amount is greater than target in this year !!'
	END
ELSE
	BEGIN
		PRINT 'Didn''t Reached the goal !'
	END
GO

----------------- 7.29 TRY CATCH 

BEGIN TRY
	DELETE FROM guests
	PRINT 'SUCCESSFULLY DELETED'
END TRY

BEGIN CATCH
		DECLARE @Error VARCHAR(200) = 'Error' + CONVERT(varchar, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
		PRINT (@Error)
END CATCH
GO


----------------- 7.30 GOTO 

DECLARE @value INT
SET @value = 0

WHILE @value <= 10
	BEGIN
	   IF @value = 2
		  GOTO printMsg
	   SET @value = @value + 1

	   	IF @value = 9
		  GOTO printMsg2
	   SET @value = @value + 1
	END
printMsg:
   PRINT 'Crossed Value 2'
printMsg2:
   PRINT 'Crossed Value 9'
GO

----------------- 7.31 WAITFOR 

PRINT 'HELLO Masum Kazi!'
WAITFOR DELAY '00:00:03'
PRINT 'GOOD LUCK'
GO

----------------- 7.32 SYSTEM STORED PROCEDURE(sp_helptext) TO GET UNENCRYPTED STORED PROCEDURE SCRIPT  

EXEC sp_helptext AddGuest
GO