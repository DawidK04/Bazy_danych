USE [Biblioteka]
GO

CREATE TABLE  [dbo].users (
	id INT IDENTITY(1,1) PRIMARY KEY ,
	[name] varchar(100) NOT NULL
)


CREATE TABLE	[dbo].[books] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[author] [varchar](100) NOT NULL,
	[category] [varchar](50) NULL,
	[publisher] [varchar](100) NOT NULL,
	[publicationYear] [int] NOT NULL,
	[isbn] [varchar](20) NULL,
	[status] [bit] NOT NULL,
	audit_user [INT] NOT NULL ,
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id)
)
GO


CREATE TABLE [dbo].[author] (
	[id] [int] IDENTITY(1,1) PRIMARY KEY ,
	[firstName] [varchar](100) ,
	[lastName] [varchar](100) ,
	[datebirthday] [DATE] ,
	[description] [varchar](500) ,
	audit_user [INT] NOT NULL ,
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id)
)

CREATE TABLE [dbo].authorBooks (
	id INT PRIMARY KEY,
	authorID INT NOT NULL ,
	bookID INT NOT NULL ,
	audit_user [INT] NOT NULL,
	FOREIGN KEY (audit_user) REFERENCES dbo.users(id),
)




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


CREATE TABLE [dbo].borrowings(
	id INT IDENTITY(1,1) PRIMARY KEY,
	bookID,
	clientID,
	borrowDate,
	returnDate,
	dueDate,
	status ("Wypozyczona", "Zwrocona", "Zalegla")
)

CREATE TABLE Reservation (

)


#zastanowic sie jakie reguly dodac do kolumn oraz czy i jak rozbudowac tabele

1:1
1:&
&:1
&:&
lista tabel:

- books
- author
- authorBooks &:&
- user (pracownicy)
- czytelnicy / klienci
- wypozyczenia (ksiazka i czytelnik)
- rezerwacja (ksiazka, czytelnik)
- kary (czytelnik, wypozyczenie)