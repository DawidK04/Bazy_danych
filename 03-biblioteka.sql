USE [Biblioteka]
GO

--DROP TABLE IF EXISTS [db].[books];
--GO

select * FROM [INFORMATION_SCHEMA].[TABLES]

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='books' )
CREATE TABLE [dbo].[books] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](200) NOT NULL, 
	[category] [varchar](50) NULL,
	[publisher] [varchar](100) NOT NULL,
	[publicationYear] [int] NOT NULL,
	[isbn] [varchar](20) NULL,
	[status] [bit] NOT NULL,
	audit_user [INT] NOT NULL ,
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id)
)

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='author' )
CREATE TABLE [dbo].[author] (
	[id] [int] IDENTITY(1,1) PRIMARY KEY ,
	[firstName] [varchar](100) ,
	[lastName] [varchar](100) ,
	[datebirthday] [DATE] ,
	[description] [varchar](500) ,
	audit_user [INT] NOT NULL ,
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id)
)

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='authorBooks' )
CREATE TABLE [dbo].authorBooks (
	--id INT PRIMARY KEY,
	authorID INT NOT NULL ,
	bookID INT NOT NULL ,
	audit_user [INT] NOT NULL,
	PRIMARY KEY (authorID, bookID),
	-- dodac relacje do autora
	-- dodac relacje do ksiazki 
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id),
)

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='users' )
CREATE TABLE [dbo].users (
	id INT IDENTITY(1,1) PRIMARY KEY,
	[name] varchar(100) NOT NULL
)

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='clients' )
CREATE TABLE [dbo].clients (
	id INT IDENTITY(1,1) PRIMARY KEY,
	[firstName] [varchar](100) NOT NULL ,
	[lastName] [varchar](100) ,
	[dateAdd] DATETIME NOT NULL DEFAULT GETDATE(),
	[datebirthday] [DATE] ,
	[email] varchar(250) NOT NULL UNIQUE ,
	[PESEL] varchar(11) NOT NULL ,
	[documentID] varchar(100) ,
	audit_user [INT],
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id)
)

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='borrowings' )
CREATE TABLE [dbo].borrowings (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	bookID INT NOT NULL,
	clientID INT NOT NULL,
	borrowDate DATETIME NOT NULL,
	returnDate DATETIME,
	dueDate DATE NOT NULL,
	[status] VARCHAR(20) NOT NULL CHECK (STATUS IN ('wypozyczona', 'zwrocona', 'zalegla'))
);
GO

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='reservations' )
CREATE TABLE [dbo].reservations (
	ID INT IDENTITY PRIMARY KEY NOT NULL,
	BOOK_ID INT NOT NULL,
	CLIENT_ID INT NOT NULL,
	--BOOK_NAME VARCHAR (100) NOT NULL,
	--CLIENT_NAME VARCHAR (100) NOT NULL,
	TIME_OF_BORROW DATETIME NOT NULL,
	FOREIGN KEY (BOOK_ID) REFERENCES dbo.books(id),
	FOREIGN KEY (CLIENT_ID) REFERENCES dbo.clients(id),
);

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_NAME ='fines' )
--select * from  sys.objects WHERE object_id = OBJECT_ID('clients')
--IF OBJECT_ID('clients') IS NOT NULL
CREATE TABLE [dbo].fines (
ID INT IDENTITY PRIMARY KEY NOT NULL,
BOOK_ID INT NOT NULL,
CLIENT_ID INT NOT NULL,
AMOUNT DECIMAL(10, 2) NOT NULL,
FINE_DATE DATETIME NOT NULL DEFAULT GETDATE(),
STATUS VARCHAR(20) NOT NULL CHECK (STATUS IN ('oplacona', 'nie zaplacona')),
FOREIGN KEY (BOOK_ID) REFERENCES dbo.books(id),
FOREIGN KEY (CLIENT_ID) REFERENCES dbo.clients(id)
);
GO

CREATE TABLE [dbo].[status] (
	id INT PRIMARY KEY ,
)




--select
--t.name,
--i.name,
--i.type_desc
--from sys.indexes i
--INNER JOIN sys.tables t ON i.object_id - t.object_id


--select i.* from sys.dm_db_index_usage_stats i
--INNER JOIN sys.tables t ON i.object_id - t.object_id