


sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

sp_configure 'clr strict security', 0;
GO
RECONFIGURE;

Insert into [dbo].[Users] ([Name],[Email],CreatedDT)
VALUES ('k4', 'k4@testmail.com', GetDate());


USE [smc]
GO


IF OBJECT_ID(N'Employees', N'U') IS NOT NULL
  DROP TABLE Employees
GO
CREATE TABLE Employees
(
	EmployeeNumber int NOT NULL,
	DateHired date NULL,
	FirstName nvarchar(20),
	LastName nvarchar(20) NOT NULL,
	HourlySalary money
);
GO

INSERT INTO Employees
VALUES(62480, N'19981025', N'James', N'Haans', 28.02),
      (35844, N'20060622', N'Gertrude', N'Monay', 14.36),
      (24904, N'20011016', N'Philom�ne', N'Guillon', 18.05),
      (48049, N'20090810', N'Eddie', N'Monsoon', 26.22),
      (25805, N'20040310', N'Peter', N'Mukoko', 22.48),
      (58405, N'19950616', N'Chritian', N'Allen', 16.45);
GO

IF OBJECT_ID('Rooms', 'U') IS NOT NULL
  DROP TABLE Rooms
GO
CREATE TABLE Rooms
(
    RoomNumber nvarchar(10),
    RoomType nvarchar(20) default N'Bedroom',
    BedType nvarchar(40) default N'Queen',
    Rate money default 85.95,
    Available bit default 1
);
GO

USE smc;
GO

INSERT INTO Rooms(RoomNumber)
VALUES(N'104');
GO
INSERT INTO Rooms(RoomNumber, BedType, Rate, Available)
VALUES(N'105', N'King', 95.50, 1),
      (N'106', N'King', 95.50, 1);
GO
INSERT INTO Rooms(RoomNumber, Available)
VALUES(N'107', 1);
GO
INSERT INTO Rooms(RoomNumber, BedType, Rate)
VALUES(N'108', N'King', 95.50);
GO
INSERT INTO Rooms(RoomNumber, Available)
VALUES(N'109', 1);
GO
INSERT INTO Rooms(RoomNumber, RoomType, Rate, Available)
VALUES(N'108', N'Conference Roome', 450, 1),
      (N'110', N'Conference Roome', 650, 1);
GO
INSERT INTO Rooms(RoomNumber, BedType, Rate, Available)
VALUES(N'201', N'Queen', 90, 1),
          (N'202', N'Queen', 90, 1),
          (N'203', N'Queen', 90, 1),
          (N'205', N'King', 98.85, 1),
          (N'207', N'King', 98.75, 1);
GO


USE [smc]
GO

SELECT [RoomNumber]
      ,[RoomType]
      ,[BedType]
      ,[Rate]
      ,[Available]
  FROM [dbo].[Rooms]

GO



SELECT [Id]
      ,[Name]
      ,[Email]
      ,[CreatedDT]
  FROM [dbo].[Users]

GO




USE smc;
GO

CREATE PROCEDURE ShowRoomInfo(@RmNumber nvarchar(100) OUTPUT, 
				@Criterion nvarchar(20))
AS EXTERNAL NAME SMCInn.[SMCInn.RoomInfo].GetInformation;
GO

--test CLR

DECLARE @RoomResult nvarchar(100);

EXECUTE dbo.ShowRoomInfo @RoomResult output, N'1';
SELECT @RoomResult AS 'Room Information';
GO