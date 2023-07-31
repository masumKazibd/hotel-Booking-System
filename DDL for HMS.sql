/*
					SQL Project Name : Hotel Booking System(HBS)
							    Trainee Name : Md. Masum Kazi   
						    	  Trainee ID : 1279032       
							Batch ID : WADA/PNTL-A/56/1
 __________________________________________________________________________________________________________________________

Table of Contents: DDL
----------------------
			 SECTION 01 -> Created a Database [HBS]
			 SECTION 02 -> Created Appropriate Tables with column definition related to the project
			 SECTION 03 -> ALTER, DROP AND MODIFY TABLES & COLUMNS
			 SECTION 04 -> CREATE CLUSTERED AND NONCLUSTERED INDEX
			 SECTION 05 -> CREATE SEQUENCE & ALTER SEQUENCE
			 SECTION 06 -> CREATE A VIEW & ALTER VIEW
			 SECTION 07 -> CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			 SECTION 08 -> CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
			 SECTION 09 -> CREATE TRIGGER (FOR/AFTER TRIGGER)
			 SECTION 10 -> CREATE TRIGGER (INSTEAD OF TRIGGER)
			 ------------------------------------------------------------------------------------------------------------

______________________________  SECTION 01 
					CREATE DATABASE WITH ATTRIBUTES
								______________________________*/


CREATE DATABASE HBS
ON
(
	name = 'hbs_data',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\hbs_data',
	size = 5MB,
	maxsize = 50MB,
	filegrowth = 5%
)
LOG ON
(
	name = 'hbs_log',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\hbs_log',
	size = 8MB,
	maxsize = 40MB,
	filegrowth = 5MB
)
GO

USE HBS
GO


/*______________________________  SECTION 02  
		          CREATE TABLES WITH COLUMN DEFINITION 
								______________________________*/

----------------- Table with IDENTITY, PRIMARY KEY & nullability CONSTRAINT... 


CREATE TABLE Room_Types
(
    Room_Type_ID INT PRIMARY KEY,
    Room_Type_Name NVARCHAR(50) NOT NULL,
    Room_Type_Description NVARCHAR(100),
    Room_Type_Capacity INT NOT NULL,
    Room_Type_Price MONEY NOT NULL
);


----------------- Table with PRIMARY KEY & FOREIGN KEY & DEFAULT CONSTRAINT... 

CREATE TABLE Rooms
(
    Room_Number INT,
    Room_Type_ID INT,
    Floor_ID INT,
    Room_Status NVARCHAR(50),
    PRIMARY KEY (Room_Number, Room_Type_ID),
    FOREIGN KEY (Room_Type_ID) REFERENCES Room_Types (Room_Type_ID)
);

GO
----------------- Table with CHECK CONSTRAINT & set CONSTRAINT name 

CREATE TABLE Guests
(
    [Guest ID] INT IDENTITY PRIMARY KEY,
    [First Name] NVARCHAR(50),
    [Last Name] NVARCHAR(50),
    Guest_Address NVARCHAR(50),
    Guest_City NVARCHAR(50),
    Guest_Country NVARCHAR(50),
    DOB DATE NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    [Mobile No.] NVARCHAR(50) NOT NULL,
    CONSTRAINT CHK_Guests_ValidDOB CHECK (DOB <= GETDATE()) -- Constraint to check valid DOB
);
GO


CREATE TABLE Bookings
(
    Booking_ID INT PRIMARY KEY,
    Guest_ID INT,
    Room_Number INT,
    Room_Type_ID INT,
    Booking_Date DATETIME DEFAULT GETDATE(),
    Check_In_Date DATE,
    Check_Out_Date DATE,
    Kids_Number INT,
    Booking_Status NVARCHAR(50),
    FOREIGN KEY (Guest_ID) REFERENCES Guests ([Guest ID]),
    FOREIGN KEY (Room_Number, Room_Type_ID) REFERENCES Rooms (Room_Number, Room_Type_ID)
);

GO

CREATE TABLE Payments
(
    Payment_ID INT PRIMARY KEY NOT NULL,
    Booking_ID INT NOT NULL,
    Payment_Date DATETIME DEFAULT GETDATE(),
    Payment_Method NVARCHAR(50) NOT NULL,
    Amount MONEY,
    FOREIGN KEY (Booking_ID) REFERENCES Bookings (Booking_ID)
);
GO


CREATE TABLE Countries
(
    Country NVARCHAR(50) PRIMARY KEY
);
GO
----------------- Table with composite PRIMARY KEY 

CREATE TABLE Cities
(
    City NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    PRIMARY KEY (City, Country),
    FOREIGN KEY (Country) REFERENCES Countries (Country)
);

GO
----------------- CREATE A SCHEMA 

CREATE SCHEMA hbs
GO
----------------- USE SCHEMA IN A TABLE 

CREATE TABLE hbs.tblCommentsInfo
(
	commentId INT,
	comment NVARCHAR(100) NULL,
	commenterAge INT NULL
)
GO

/*______________________________  SECTION 03  
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
								______________________________*/
CREATE TABLE SampleTable
(
    ID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    Email NVARCHAR(100),
    IsActive BIT
); 
GO
----------------- Update column definition 

ALTER TABLE Payments
ALTER COLUMN Payment_Method NVARCHAR(40) NOT NULL
GO

----------------- ADD column with DEFAULT CONSTRAINT 

ALTER TABLE Guests
ADD Age INT DEFAULT 18
GO
----------------- ADD CHECK CONSTRAINT with defining name 

ALTER TABLE Guests
ADD 
CONSTRAINT CK_emailValidate CHECK(Email LIKE '%@%' )
GO

----------------- DROP COLUMN 
ALTER TABLE SampleTable
DROP COLUMN IsActive
GO

----------------- DROP TABLE 

DROP TABLE SampleTable
GO

----------------- DROP SCHEMA 

--DROP SCHEMA hbs
--GO

/*______________________________  SECTION 04  
		          CREATE CLUSTERED AND NONCLUSTERED INDEX
								______________________________*/

----------------- NON Clustered Index
CREATE UNIQUE NONCLUSTERED INDEX cityIndex
ON Cities
(
	City
)
GO



/*______________________________  SECTION 05  
							 CREATE SEQUENCE
								______________________________*/

CREATE SEQUENCE seqNum
	AS INT
	START WITH 10
	INCREMENT BY 15
	MINVALUE 0
	MAXVALUE 500
	CYCLE
	CACHE 5
GO

--============== ALTER SEQUENCE ============--

ALTER SEQUENCE seqNum
	MAXVALUE 300
	CYCLE
	CACHE 7
GO


/*______________________________  SECTION 06  
							  CREATE A VIEW
								______________________________*/

CREATE VIEW VW_GuestsInfo
AS
SELECT [Guest ID], [First Name], Guest_Address
FROM Guests
GO
SELECT * FROM VW_GuestsInfo
GO
----------------- VIEW WITH ENCRYPTION, SCHEMABINDING & WITH CHECK OPTION
----------------- A VIEW to get today Bookings information

CREATE VIEW VW_TodayBookings
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT Booking_ID, Guest_ID, Room_Number, Room_Type_ID 
FROM dbo.Bookings
WHERE CONVERT(DATE, Booking_Date) = CONVERT(DATE, GETDATE())
WITH CHECK OPTION
GO

----------------- ALTER VIEW 
ALTER VIEW VW_GuestsInfo
AS
SELECT [Guest ID], [First Name], Guest_Address, DOB, Guest_City, Guest_Country
FROM Guests
GO


/*______________________________  SECTION 07  
							 STORED PROCEDURE
								______________________________*/

----------------- STORED PROCEDURE for insert data using parameter 

CREATE PROCEDURE AddGuest
						@FirstName NVARCHAR(50),
						@LastName NVARCHAR(50),
						@DOB DATE,
						@Email NVARCHAR(50),
						@MobileNo NVARCHAR(50),
						@GuestAddress NVARCHAR(50),
						@GuestCity NVARCHAR(50),
						@GuestCountry NVARCHAR(50)
AS
BEGIN
    -- Insert the new guest record into the Guests table
    INSERT INTO Guests ([First Name], [Last Name], DOB, Email, [Mobile No.], Guest_Address, Guest_City, Guest_Country)
    VALUES (@FirstName, @LastName, @DOB, @Email, @MobileNo, @GuestAddress, @GuestCity, @GuestCountry);

    SELECT 'Guest added successfully.' AS Result;
END;
GO

----------------- STORED PROCEDURE for insert data with OUTPUT parameter 
CREATE PROCEDURE InsertRoomType
						@Room_Type_Name NVARCHAR(50),
						@Room_Type_Description NVARCHAR(100),
						@Room_Type_Capacity INT,
						@Room_Type_Price MONEY,
						@New_Room_Type_ID INT OUTPUT
AS
BEGIN
    -- Insert the new room type record into the Room_Types table
    INSERT INTO Room_Types (Room_Type_Name, Room_Type_Description, Room_Type_Capacity, Room_Type_Price)
    VALUES (@Room_Type_Name, @Room_Type_Description, @Room_Type_Capacity, @Room_Type_Price);

    -- Get the newly generated Room_Type_ID
    SET @New_Room_Type_ID = SCOPE_IDENTITY();

    -- Return the newly generated Room_Type_ID as the output parameter
    SELECT @New_Room_Type_ID AS NewRoomTypeID;
END;

GO


----------------- STORED PROCEDURE for UPDATE data 
CREATE PROCEDURE UpdateRoom
						@Room_Number INT,
						@Room_Type_ID INT,
						@Floor_ID INT,
						@Room_Status NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified room exists
    IF EXISTS (
        SELECT 1
        FROM Rooms
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @Room_Type_ID
    )
    BEGIN
        -- Update the room details
        UPDATE Rooms
        SET
            Floor_ID = @Floor_ID,
            Room_Status = @Room_Status
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @Room_Type_ID;

        SELECT 'Room updated successfully.' AS Result;
    END
    ELSE
    BEGIN
        SELECT 'Room not found. Update failed.' AS Result;
    END
END;
GO

----------------- STORED PROCEDURE for DELETE Table data 
CREATE PROCEDURE DeleteRoom
    @Room_Number INT,
    @Room_Type_ID INT
AS
BEGIN

    -- Check if the specified room exists
    IF EXISTS (
        SELECT 1
        FROM Rooms
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @Room_Type_ID
    )
    BEGIN
        -- Delete the room
        DELETE FROM Rooms
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @Room_Type_ID;

        SELECT 'Room deleted successfully.' AS Result;
    END
    ELSE
    BEGIN
        SELECT 'Room not found. Deletion failed.' AS Result;
    END
END;
GO
----------------- TRY CATCH IN A STORED PROCEDURE & RAISERROR WITH ERROR NUMBER AND ERROR MESSAGE 
CREATE PROCEDURE DeleteRoomType
    @Room_Type_ID INT
AS
BEGIN
    BEGIN TRY
        -- Delete the room type
        DELETE FROM Room_Types
        WHERE Room_Type_ID = @Room_Type_ID;

        PRINT 'Room type deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle the error and print a simple error message
        PRINT 'An error occurred while deleting the room type.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH
END;
Go
----------------- ALTER STORED PROCEDURE 
ALTER PROCEDURE DeleteRoom
    @Room_Number INT,
    @R_Type_ID INT
AS
BEGIN

    -- Check if the specified room exists
    IF EXISTS (
        SELECT 1
        FROM Rooms
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @R_Type_ID
    )
    BEGIN
        -- Delete the room
        DELETE FROM Rooms
        WHERE Room_Number = @Room_Number AND Room_Type_ID = @R_Type_ID;

        SELECT 'Room deleted successfully.' AS Result;
    END
    ELSE
    BEGIN
        SELECT 'Room not found. Deletion failed.' AS Result;
    END
END;
GO

/*______________________________  SECTION 08  
								 FUNCTION
								______________________________*/

----------------- A SCALAR FUNCTION 
-- A Scalar Function to get Current Year Total Net Sales


CREATE FUNCTION fnCurrentYearPayments()
RETURNS MONEY
AS
BEGIN
	DECLARE @totalPayments MONEY

	SELECT @totalPayments = SUM((Amount))
	FROM Payments
	WHERE YEAR(Payments.Amount) = YEAR(GETDATE())

	RETURN @totalPayments
END
GO


----------------- A SIMPLE TABLE VALUED FUNCTION 
----------------- A Inline Table Valued Function to get monthly total sales, discount & net sales using two parameter @year & @month

CREATE FUNCTION fnMonthlyPayments(@year INT, @month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
			SUM(Amount) AS 'Total Payments',
			SUM(Amount) AS 'Net Amonu'
	FROM Payments
	WHERE YEAR(Payments.Payment_Date) = @year AND MONTH(Payments.Payment_Date) = @month

)
GO

----------------- ALTER FUNCTION 

ALTER FUNCTION fnMonthlyPayments(@year INT, @month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
			SUM(Payment_ID) AS 'Total Payments',
			SUM(Amount) AS 'Net Amonu'
	FROM Payments
	WHERE YEAR(Payments.Payment_Date) = @year AND MONTH(Payments.Payment_Date) = @month
)
GO
/*______________________________  SECTION 09  
							FOR/AFTER TRIGGER
								______________________________*/

CREATE TRIGGER tr_RoomTypes_UpdateDescription
ON Room_Types
AFTER INSERT, UPDATE
AS
BEGIN
    -- Update Room_Type_Description based on Room_Type_Name, Room_Type_Capacity, and Room_Type_Price
    UPDATE Room_Types
    SET
        Room_Type_Description = rt.Room_Type_Name + ' - ' + CAST(rt.Room_Type_Capacity AS NVARCHAR(10)) + ' people, $' + CAST(rt.Room_Type_Price AS NVARCHAR(20))
    FROM Room_Types rt
    INNER JOIN inserted I ON rt.Room_Type_ID = I.Room_Type_ID;
END;

GO

/*______________________________  SECTION 10  
							INSTEAD OF TRIGGER
								______________________________*/


----------------- AN INSTEAD OF TRIGGER ON VIEW 

CREATE TRIGGER trVW_GuestsInfo
ON VW_GuestsInfo
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO VW_GuestsInfo([Guest ID], Guest_Address)
	SELECT i.[Guest ID], i.Guest_City FROM inserted i
END
GO

----------------- ALTER TRIGGER 

ALTER TRIGGER trVW_GuestsInfo
ON VW_GuestsInfo
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO VW_GuestsInfo(Guest_Country,[Guest ID], Guest_Address)
	SELECT i.Guest_Country, i.[Guest ID], i.Guest_City FROM inserted i
END
GO


