--T-SQL Reference Sheet
--CREATED BY: Sikandar
--UPDATED: 2016-02-27
--TESTED WITH: SQL SERVER 2012

/*

OPERATORS
-----------------------------

Arithmetic Operator		Meaning																
-------------------		--------------------------------------------------------------------
+ (Add)					Addition
- (Subtract)			Subtraction
* (Multiply)			Multiplication
/ (Divide)				Division
% (Modulo)				Returns the integer remainder of a division.

Logical Operators		Meaning																
-------------------		--------------------------------------------------------------------
ALL						TRUE if all of a set of comparisons are TRUE.
AND						TRUE if both Boolean expressions are TRUE.
ANY						TRUE if any one of a set of comparisons are TRUE.
BETWEEN					TRUE if the operand is within a range.
EXISTS					TRUE if a subquery contains any rows.
IN						TRUE if the operand is equal to one of a list of expressions.
LIKE					TRUE if the operand matches a pattern.
NOT						Reverses the value of any other Boolean operator.
OR						TRUE if either Boolean expression is TRUE.
SOME					TRUE if some of a set of comparisons are TRUE.

Compound Operators		Meaning																
-------------------		--------------------------------------------------------------------
+=						Adds some amount to the original value and sets the original value to the result.
-=						Subtracts some amount from the original value and sets the original value to the result.
*=						Multiplies by an amount and sets the original value to the result.
/=						Divides by an amount and sets the original value to the result.
%=						Divides by an amount and sets the original value to the modulo.
&=						Performs a bitwise AND and sets the original value to the result.
^=						Performs a bitwise exclusive OR and sets the original value to the result.
|=						Performs a bitwise OR and sets the original value to the result.

Comparison Operators	Meaning																
-------------------		--------------------------------------------------------------------
=						Equal to
>				        Greater than
<				        Less than
>=						Greater than or equal to
<=						Less than or equal to
<>						Not equal to
!=						Not equal to (not ISO standard)
!<						Not less than (not ISO standard)
!>						Not greater than (not ISO standard)


DATATYPES
-----------------------------

DataType	Range																		Storage
----------	------------------------------------------------------------------------	-----------
BigInt		-2^63 (-9,223,372,036,854,775,808) to 2^63-1 (9,223,372,036,854,775,807)    8 Bytes
Int			-2^31 (-2,147,483,648) to 2^31-1 (2,147,483,647)							4 Bytes
TinyInt		0 to 255																	1 Byte
SmallInt	-2^15 (-32,768) to 2^15-1 (32,767)											2 Bytes

DataType	Range																		Storage
----------	------------------------------------------------------------------------	-----------		
Bit			An integer data type that can take a value of 1, 0, or NULL.				1 Bit

DataType	Precision																	Storage
----------	------------------------------------------------------------------------	-----------	
Numeric		29-38																		17 Bytes
Decimal     29-38																		17 Bytes

DataType	Range																		Storage
----------	------------------------------------------------------------------------	-----------
Money       -922,337,203,685,477.5808 to 922,337,203,685,477.5807						8 bytes
SmallMoney	-214,748.3648 to 214,748.3647												4 bytes
 
DataType	Precision																	Storage
----------	------------------------------------------------------------------------	-----------
FLOAT		15 digits																	8 bytes
REAL        15 digits																	8 bytes

DataType		FORMAT																	Accuracy
----------		--------------------------------------------------------------------	---------------
Date			YYYY-MM-DD																One day
DateTimeOffset	YYYY-MM-DD hh:mm:ss[.nnnnnnn] [{+|-}hh:mm]								100 nanoseconds
DateTime2		YYYY-MM-DD hh:mm:ss[.fractional seconds]								100 nanoseconds
SmallDateTime	YYYY-MM-DD hh:mm:ss														One minute
DateTime        YYYY-MM-DD hh:mm:ss														.997 seconds
Time			hh:mm:ss[.nnnnnnn]														100 nanoseconds

DataType		Range																	Storage
----------		--------------------------------------------------------------------	---------------
Char			1 through 8,000
VarChar			1 through 8,000 OR VarChar(MAX)											2^31-1 bytes
Text																					2^31-1 bytes
Nchar           1 through 4,000															
NvarChar        1 through 4,000															2^31-1 bytes
Ntext																					2^30-1 bytes

DataType		Range																	Storage
----------		--------------------------------------------------------------------	---------------
Binary          1 through 8,000															
VarBinary       1 through 8,000															2^31-1 bytes
Image																					2^31-1 bytes
*/


--Creating New Database
CREATE DATABASE HRC;

--Select a Database for Quering
USE HRC;

--CREATE TABLE STATEMENT
CREATE TABLE dbo.Login(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	UserName nvarchar(30) NOT NULL,
	Password nvarchar(60) NOT NULL,
	CreatedDate DATE DEFAULT GETDATE(),
	UpdatedDate DATE DEFAULT GETDATE()
);

--CREATE TABLE STATEMENT WITH FOREIGN KEY
CREATE TABLE dbo.PersonDetails(
	Id INT PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30),
	BirthDay Date,
	Gender CHAR CONSTRAINT GN_DEF DEFAULT 'M',
	Education TEXT,
	Address TEXT,
	Rank INT,
	Phonenumber INT
	CONSTRAINT FK_Person FOREIGN KEY (Id)
	REFERENCES Login(Id) ON DELETE CASCADE
);

--CREATE TABLE WITH CHECK CONSTRAINT TO LIMIT THE VALUE RANGE THAT CAN BE PLACED IN A COLUMN.
CREATE TABLE dbo.PersonAge(
	Id INT PRIMARY KEY NOT NULL,
	Age INT CHECK (Age > 17)
);

--INSERT RECORD STATEMENT
INSERT INTO dbo.Login VALUES('alex', 'secret');

INSERT INTO dbo.PersonDetails(Id, FirstName, Gender, BirthDay)
VALUES(1,'Alexander', 'M', '1997-08-24');

--UPDATE RECORD STATEMENT
UPDATE dbo.Login SET Password = 'mypassword'
WHERE UserName = 'alex';

--DELETE RECORD STATEMENT
DELETE FROM dbo.Login WHERE UserName = 'alex';

--SHOW RECORD STATEMENT
SELECT * FROM dbo.Login;
SELECT * FROM dbo.PersonDetails;

--ADD COLUMN TO EXSISTING TABLE
ALTER TABLE dbo.Login
ADD SessionId VARCHAR(50);

ALTER TABLE dbo.Login
ADD SessionId VARCHAR(50), NewColumn INT NULL;

--CHANGE EXSISTING COLUMN DATATYPE 
ALTER TABLE dbo.Login
ALTER COLUMN SessionId NVARCHAR(60);

--DROP EXSISTING COLUMN
ALTER TABLE dbo.Login DROP COLUMN Id;

--ADD CONSTRAINT TO EXSISTING TABLE
ALTER TABLE dbo.Login ADD LogedIn CHAR CONSTRAINT DF_Login_Bar DEFAULT ('N')

--ADD CONSTRAINT TO EXSISTING COLUMN
ALTER TABLE dbo.Login ADD CONSTRAINT DF_Login_Bar DEFAULT 'N' FOR LogedIn;

--DROP EXSISTING CONSTRAINT
ALTER TABLE dbo.Login DROP CONSTRAINT DF_Login_Bar;

--ADD PRIMARY KEY
ALTER TABLE dbo.Login
ADD PRIMARY KEY (Id);

--ADD IDENTITY
Alter TABLE dbo.Login
ADD id INT IDENTITY(1,1) NOT NULL;

--ADD FOREIGN KEY
ALTER TABLE dbo.Login
ADD FOREIGN KEY (Id)
REFERENCES PersonDetails(Id);

--ADD CHECK
ALTER TABLE dbo.Login
ADD CHECK (id > 0 );

--DISPLAY RECORDS FROM TABLE
SELECT * FROM dbo.Login;

--DISPLAY SPECIFIC COLUMNS FROM TABLE
SELECT Username, Password FROM dbo.Login;

--PROVIDE COLUMN ALIAS FOR EASY READBILITY
SELECT Username AS [User], Password AS [User Password] FROM dbo.Login;

--FILTER RECORDS FROM TABLE
SELECT * FROM dbo.Login WHERE UserName = 'alex';

--SEARCH FOR A SPECIFIED PATTREN IN A COLUMN
SELECT * FROM dbo.Login WHERE UserName LIKE '%alex';

--SEARCH FROM START AND END OF THE CHRACTER
SELECT * FROM dbo.Login WHERE UserName LIKE '%manager%';

-- '_' ANY SINGLE CHRACTER
SELECT * FROM dbo.Login WHERE UserName LIKE '_lex';

-- RANGE OF CHRACTERS
SELECT * FROM dbo.Login WHERE UserName LIKE '[g-m]ary';

-- EXCLUDE CHRACTERS
SELECT * FROM dbo.Login WHERE UserName LIKE '[^g]ary';

--NOT LIKE
SELECT * FROM dbo.Login WHERE UserName NOT LIKE '_lex';


--STRING CONCATINATION
SELECT UserName + ', ' + Password FROM dbo.Login;

--DISPLAY DISTINCT RECORDS FROM TABLE
SELECT DISTINCT(Password) FROM dbo.Login;

--SPECIFY MULTIPLE VALUES IN A WHERE CLAUSE
SELECT Username From dbo.Login WHERE UserName IN('alex', 'alan');

--DISPLAY VALUES WITHIN A RANGE.
SELECT Username FROM dbo.Login
WHERE CreatedDate BETWEEN '2012-04-12' AND '2015-04-12';

--DISPLAY RECORDS WHICH HAVE NULL VALUE
SELECT * FROM dbo.Login WHERE Password IS NULL;

--DISPLAY RECORDS WHICH DONT HAVE NULL VALUE. '<>' := NOT EQUAL
SELECT * FROM dbo.Login WHERE Password <> 'A' OR Password IS NOT NULL;

--SORT THE RESULT-SET BY ONE OR MORE COLUMNS WITH 'ORDER BY'
SELECT * FROM dbo.PersonDetails ORDER BY FirstName;

--SORT THE RESULT SET BY ASCENDING ORDER WITH 'ASC'
SELECT * FROM dbo.PersonDetails ORDER BY FirstName ASC;

--SORT THE RESULT SET BY DESCENDING ORDER WITH 'DESC'
SELECT * FROM dbo.PersonDetails ORDER BY FirstName DESC;

--SORT THE RESULT-SET BY ONE OR MORE COLUMNS WITH 'ORDER BY'
SELECT FirstName, LastName FROM dbo.PersonDetails ORDER BY FirstName, LastName;

--GROUP THE RESULT-SET BY ONE OR MORE COLUMNS WITH 'GROUP BY'
SELECT Address, COUNT(*) AS Totals FROM dbo.PersonDetails
GROUP BY Address;

--GROUP THE RESULT-SET BY ONE OR MORE COLUMNS WITH 'GROUP BY'
SELECT FirstName, LastName FROM dbo.PersonDetails
GROUP BY FirstName, LastName;

--SPECIFY THE NUMBER OF RECORDS TO RETURN
SELECT TOP 20 * FROM dbo.Login;

--SPECIFY THE NUMBER OF RECORDS TO RETURN
SELECT TOP 20 FirstName, LastName FROM dbo.PersonDetails;

--SPECIFY THE NUMBER OF RECORDS TO RETURN BY PERCENTAGE
SELECT TOP 20 PERCENT FirstName, LastName FROM dbo.PersonDetails;

--RETURN ADDITIONAL RECORDS WITH 'WITH TIES' 
SELECT TOP (10) WITH TIES FirstName FROM dbo.PersonDetails
ORDER BY FirstName DESC;

--COUNT NUMBER OF RECORDS
SELECT COUNT(*) FROM dbo.PersonDetails;

--COUNT DISTINCT NUMBER OF RECORDS IN A COLUMN
SELECT COUNT(DISTINCT FirstName) AS [Number of People]
FROM dbo.PersonDetails;

--RETURNS AVERAGE VALUE OF A NUMERIC COLUMN
SELECT AVG(Id) AS [AVG]
FROM dbo.Login;

--RETURNS MAX VALUE OF A NUMERIC COLUMN
SELECT MAX(Rank) AS [MAX]
FROM dbo.PersonDetails;

--RETURNS MIN VALUE OF A NUMERIC COLUMN
SELECT MIN(Rank) AS [MIN]
FROM dbo.PersonDetails;

--RETURNS TOTAL SUM OF A NUMERIC COLUMN
SELECT SUM(Rank) AS [SUM]
FROM dbo.PersonDetails;

--RETURNS STATISTICAL VARIANCE OF A NUMERIC COLUMN
SELECT VAR(Rank) AS [Variance]
FROM dbo.PersonDetails;

--PERFORMING MATH WITH ARITHMETIC OPERATORS
SELECT (2 + 2) AS [ADDITION],
(6 - 3) AS [SUBTRACTION],
(8 / 2) AS DIVISION, (4 * 5) AS MULTIPLICATION, 
(12 % 5) AS [Modulo];

--FORMULATION
SELECT (37 * 9 / 5 + 32);

--CASE STATEMENT
SELECT FirstName,
CASE Gender
	WHEN 'M' THEN 'Male'
	WHEN 'F' THEN 'Female'
	ELSE 'Unknown'
END AS [Gender]
FROM PersonDetails;

--FILTER RECORDS FROM TABLE BY SPECIFYING DATE
SELECT UserName, CreatedDate
FROM hrc.dbo.Login
Where CreatedDate = '2016-02-27'

--RETURNS VALUES WITHIN A RANGE USING COMPARESON OPERATORS.
SELECT UserName, CreatedDate
FROM hrc.dbo.Login
WHERE CreatedDate >= '2016-02-20' AND CreatedDate <= '2016-02-27';

--RETURNS THE SPECIFIED DATEPART OF THE SPECIFIED DATE IN INTEGER VALUE
SELECT DATEPART(YEAR, CreatedDate) AS [Year],
DATEPART(MONTH, CreatedDate) AS [Month],
DATEPART(DAY, CreatedDate) AS [Day],
DATEPART(WEEKDAY, CreatedDate) AS [WeekDay]
FROM hrc.dbo.Login;

--RETURNS THE SPECIFIED DATEPART OF THE SPECIFIED DATE IN CHARACTER STRING
SELECT DATENAME(YEAR, CreatedDate) AS [Year],
DATENAME(MONTH, CreatedDate) AS [Month],
DATENAME(DAY, CreatedDate) AS [Day],
DATENAME(WEEKDAY, CreatedDate) AS [WeekDay]
FROM hrc.dbo.Login;

--RETURNS THE TIME BETWEEN TWO DATES
SELECT DATEDIFF(YEAR, '2013-12-31 23:59:59.9999999', '2016-01-01 00:00:00.0000000');

--ADD A SPECIFED TIME INTERVAL FROM A DATE.
SELECT DATEADD(MONTH, 1, '2016-08-30');

--SUBTRACT A SPECIFED TIME INTERVAL FROM A DATE.
SELECT DATEADD(MONTH, -1, '2016-08-30');

--RETURNS THE CURRENT SYSTEM DATETIME
SELECT SYSDATETIME();

--RETURNS THE SYSTEM DATETIME OFFSET
SELECT SYSDATETIMEOFFSET();

--RETURNS A DATE VALUE FOR THE SPECFIED YEAR, MONTH, DAY.
SELECT DATEFROMPARTS (2016, 03, 13)

--RETURNS A TIME VALUE FOR THE SPECFIED TIME AND WITH THE SPECIFIED PRECISION.
SELECT TIMEFROMPARTS(22, 45, 0, 0, 0);

--RETURNS A VALUE FORMATTED WITH THE SPECIFIED FORMAT.
SELECT FORMAT(CreatedDate, 'yyyy:MM:dd', 'en-US')

--RETURNS CHRACTER LENGTH
SELECT Password, LEN(Password) AS [Password Length]
FRom dbo.Login;

--RETURNS NUMBER OF BYTES
SELECT Password, DATALENGTH(password) AS [Password Bytes]
FRom dbo.Login;

--REPLACE CHRACTERS
SELECT UserName, REPLACE(UserName, 'a', 'A')
FROM dbo.Login;

--RETURNS NUMBER OF SAME CHRACTERS
SELECT REPLICATE('A', 10);

--RETURNS CHRACTERS AS LOWER AND UPPER CASE
SELECT LOWER(UserName), UPPER(UserName)
FRom dbo.Login;

--TRIM SPACES, RTRIM = Right TRIM AND LTRIM = LEFT TRIM
SELECT RTRIM(LTRIM(UserName))
FROM dbo.Login;

--TRIM CHRACTERS
SELECT SUBSTRING(UserName, 1,3)
FROM dbo.Login;

--TRIM CHRACTERS FROM LEFT AND RIGHT
SELECT UserName, LEFT(UserName,3), RIGHT(UserName,3)
FROM dbo.Login;

--INNER JOIN RETURNS ALL ROWS FROM BOTH TABLES AS LONG AS THERE IS A MATCH BETWEEN THE COLUMNS IN BOTH TABLES.
SELECT Login.Username, PersonDetails.FirstName
FROM dbo.Login
INNER JOIN dbo.PersonDetails
ON dbo.Login.Id=dbo.PersonDetails.Id;

--LEFT JOIN RETURNS ALL ROWS FROM THE LEFT TABLE, WITH THE MATCHING ROWS IN THE RIGHT TABLE. The result is NULL in the right side when there is no match.
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
LEFT JOIN PersonDetails
ON Login.Id=PersonDetails.Id
ORDER BY PersonDetails.FirstName;

--RIGHT JOIN RETURNS ALL ROWS FROM THE RIGHT TABLE, WITH THE MATCHING ROWS INT THE LEFT TABLE. The result is NULL in the left side when there is no match.
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
RIGHT JOIN PersonDetails
ON Login.Id=PersonDetails.Id
ORDER BY PersonDetails.FirstName;

--FULL OUTER JOIN RETURNS ALL ROWS FROM THE LEFT TABLE AND FROM THE RIGHT TABLE.
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
FULL OUTER JOIN PersonDetails
ON Login.Id=PersonDetails.Id
ORDER BY PersonDetails.FirstName;

--A CROSS JOIN THAT DOES NO HAVE A WHERE CLAUSE PRODUCES THE CARTESIAN PRODUCT OF THE TABLES INVOLVED IN THE JOIN. 
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
CROSS JOIN PersonDetails
ORDER BY PersonDetails.FirstName;

--IF A WHERE CLAUSE IS ADDED, THE CROSS JOIN BEHAVES AS AN INNER JOIN.
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
CROSS JOIN PersonDetails
WHERE Login.Id = PersonDetails.Id
ORDER BY PersonDetails.FirstName;

--SUBQUERY IS A QUERY THAT IS NESTED INSIDE A SELECT, INSERT, UPDATE, OR DELETE STATEMENT, OR INSIDE ANOTHER SUBQUERY.
SELECT FirstName FROM dbo.PersonDetails
WHERE Rank = (SELECT MIN(Rank) FROM dbo.PersonDetails);

--SPECIFIES A SUBQUERY TO TEST FOR THE EXISTENCE OF ROWS.
SELECT FirstName FROM dbo.PersonDetails
WHERE EXISTS Rank = (SELECT MIN(Rank) FROM dbo.PersonDetails);

--SPECIFIES A SUBQUERY WITH 'NOT EXISTS' WHICH IS THE OPPOSITE OF EXISTS.
SELECT FirstName FROM dbo.PersonDetails
WHERE NOT EXISTS Rank = (SELECT MIN(Rank) FROM dbo.PersonDetails);

--Converts an expression of one data type to another.
SELECT CAST(12345 AS INT);

--Converts an expression of one data type to another.
SELECT convert(INT, 12345) 

--RETURNS THE RESULT OF AN EXPRESSION, TRANSLATED TO THE REQUESTED DATATYPE IN SQL SERVER.
SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result;

--CREATE A VIRTUAL TABLE WHOSE CONTENTS ARE DEFINED BY A QUERY.
CREATE VIEW [User View] AS
SELECT Login.UserName, PersonDetails.FirstName
FROM Login
FULL OUTER JOIN PersonDetails
ON Login.Id=PersonDetails.Id;

--SELECT THE VIEW AS TABLE
SELECT * FROM [User View];

--MODIFY A PREVIOUSLY CREATED VIEW
ALTER VIEW [User View] AS
SELECT * FROM dbo.Login;

--DELETE A VIEW WITH THE DROP VIEW COMMAND
DROP VIEW [User View];

--VARIABLES ARE DECLARED IN THE BODY OF A BATCH OR PROCEDURE WITH THE 'DECLARE' STATEMENT
DECLARE @find varchar(30); 
SET @find = '%alex%'; 
SELECT * FROM dbo.Login WHERE UserName LIKE @find; 

--SET VARIABLE TO A QUERY
DECLARE @Result1 INT;
DECLARE @Result2 INT; 
SET @Result1 = (SELECT 2 + 2);
SET @Result2 = (SELECT @Result1 + 2 * 2);
SELECT @Result2 AS [Result];

--USING CONDITIONS ON THE EXECUTION OF A TRANSACT-SQL STATEMENT
DECLARE @Age INT;
SET @Age = 17;

IF @Age <= 30
    PRINT 'You are less then ' + CONVERT(VARCHAR(3), @Age) + ' years old.';
ELSE IF @Age >=20
	PRINT 'You are greater then ' + CONVERT(VARCHAR(3), @Age) + ' years old.';
ELSE
    PRINT 'You are ' + CONVERT(VARCHAR(3), @Age) + ' years old.';

--STORED PROCEDURE IS A GROUP OF TRANSACT-SQL STATEMENTS COMPILED INTO A SINGLE EXECUTION PLAN.
CREATE PROCEDURE uspCreateUser
	@UserName VARCHAR(30),
	@Password VARCHAR(60)
AS
	SET NOCOUNT ON;

	INSERT INTO dbo.Login(UserName, Password) VALUES(@UserName, @Password);
GO

--EXECUTE A STORED PROCEDURE WITH PARAMATERS
EXEC uspCreateUser 'John','MyPassword';

--STORED PROCEDURE CAN ALSO RETURN OUTPUT PARAMETERS AND RETURN VALUES
CREATE PROCEDURE uspCountUsers @TotalUsers INT OUTPUT
AS
SELECT COUNT(*) FROM dbo.Login;

GO

--EXECUTE A STORED PROCEDURE THAT RETURNS OUTPUT
DECLARE @TotalUsers int
EXEC uspCountUsers @TotalUsers OUTPUT

--LOCAL TEMPORARY STORED PROCEDURE
CREATE PROCEDURE #tspShowRows
	@TableName Varchar(50) 
AS 
BEGIN 
 DECLARE @query NVARCHAR(MAX);
 set @query = 'SELECT TOP 10 * FROM '+ @TableName 
 EXEC sp_executesql @query
END

EXEC #tspShowRows 'dbo.Login';

--GLOBAL TEMPORARY STORED PROCEDURE
CREATE PROCEDURE ##tspShowRows
	@TableName Varchar(50) 
AS 
BEGIN 
 DECLARE @query NVARCHAR(MAX);
 set @query = 'SELECT TOP 10 * FROM '+ @TableName 
 EXEC sp_executesql @query
END

EXEC ##tspShowRows 'dbo.Login';

--MODIFY STORED PROCEDURE
ALTER PROCEDURE uspCreateUser
	@UserName VARCHAR(30)
AS
	SET NOCOUNT ON;

	INSERT INTO dbo.Login(UserName) VALUES(@UserName);
GO

--DELETE STORED PROCEDURE
DROP PROCEDURE uspCreateUser;

--CREATE A USER DEFINED FUNCTION IN SQL SERVER
CREATE FUNCTION dbo.StripWWWandCom (@input VARCHAR(250))
RETURNS VARCHAR(250)
AS BEGIN
    DECLARE @Work VARCHAR(250)

    SET @Work = @Input

    SET @Work = REPLACE(@Work, 'www.', '')
    SET @Work = REPLACE(@Work, '.com', '')

    RETURN @work
END

--EXECUTE A FUNCTION
SELECT dbo.StripWWWandCom('www.hello.com');

--MODIFY FUNCTION
ALTER FUNCTION dbo.StripWWWandCom (@input VARCHAR(250))
RETURNS VARCHAR(250)
AS BEGIN
    DECLARE @Work VARCHAR(250)

    SET @Work = @Input

    SET @Work = REPLACE(@Work, 'www.', '')
    SET @Work = REPLACE(@Work, '.com', '')

    RETURN @work
END

--DELETE FUNCTION
DROP FUNCTION dbo.StripWWWandCom;

--LOCAL TEMPORARY TABLE
CREATE TABLE #temptable (col1 int);
GO
INSERT INTO #temptable
VALUES (10);
GO
SELECT * FROM #temptable;
GO
IF OBJECT_ID(N'tempdb..#temptable', N'U') IS NOT NULL 
DROP TABLE #temptable;
GO

--INSERT MULTIPLE VALUES INTO TABLE VARIABLE
declare @gender table
(
    gender varchar(1000)
)

insert into @gender values ('MALE')
insert into @gender values ('FEMALE')
insert into @gender values ('OTHER')

select * from @gender;

--SHOW TABLE DEFINATION
sp_help 'dbo.Login'

--RENAME TABLE
sp_RENAME 'dbo.Login' , 'Login_RN'

--RENAME COLUMN NAME
sp_RENAME 'dbo.Login.UserName' , 'User', 'COLUMN'

--CREATE A TABLE DUBLICATE
SELECT * INTO LOGIN_CPY FROM dbo.Login;

--CREATE A TRIGGER THAT NOTIFIES A USER WHEN THE SPECIFIED TABLE CHANGES.
CREATE TRIGGER reminder1
ON dbo.Login
AFTER INSERT, UPDATE 
AS RAISERROR ('You have inserted or updated a record', 16, 10);
GO

--CREATE A TRIGGER THAT SENDS AN E-MAIL TO A SPECIFIED USER WHEN THE SPECIFIED TABLE CHANGES.
CREATE TRIGGER reminder2
ON dbo.Login
AFTER INSERT, UPDATE, DELETE 
AS
   EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'HRC Administrator',
        @recipients = 'mary@example.com',
        @body = 'Don''t forget to print a report for the sales force.',
        @subject = 'Reminder';
GO

--MODIFY TRIGGER
ALTER TRIGGER reminder2
ON dbo.Login
AFTER INSERT, UPDATE, DELETE 
AS
   EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'HRC Administrator',
        @recipients = 'john@example.com',
        @body = 'Don''t forget to print a report for the sales force.',
        @subject = 'Reminder';
GO

--DELETE TRIGGER
DROP TRIGGER reminder2;


--STRUCTURED ERROR HANDLING
BEGIN TRY

	SELECT 1/0;

END TRY
BEGIN CATCH

SELECT
	ERROR_NUMBER() AS ErrorNumber,
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage
END CATCH

--CREATE A TRANSACTION
BEGIN TRANSACTION;

DELETE FROM dbo.Login WHERE Id = 4;

COMMIT TRANSACTION;


--CREATE A TRANSACTION WITH STRUCTURED ERROR HANDLING
BEGIN TRANSACTION UserDelete
	WITH MARK N'Deleting a User';
BEGIN TRY

DELETE FROM dbo.Login WHERE Id = 4;

END TRY

BEGIN CATCH

SELECT
	ERROR_NUMBER() AS ErrorNumber,
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage

IF @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;

END CATCH;

IF @@TRANCOUNT > 0
	COMMIT TRANSACTION

--CREATE AN ALIAS TYPE BASED ON THE VARCHAR DATATYPE
CREATE TYPE CST
FROM varchar(11) NOT NULL;

--DELETE ALIAS TYPE
DROP TYPE CST;