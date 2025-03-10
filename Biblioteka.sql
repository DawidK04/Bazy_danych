-- Biblioteka (baza danych)

CREATE DATABASE Biblioteka;
GO

SELECT name, database_id, create_date
FROM sys.databases
WHERE name='Biblioteka'
GO

c:
cd ./Dell
mkdir BD\g1

CREATE DATABASE Biblioteka_new
ON PRIMARY
(
	NAME = 'Biblioteka_new'
	FILENAME = 'C:\Dell\BD\g1\Baza_biblioteka.mdf',
	SIZE = 10MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'Biblioteka_log',
	FILENAME = 'C:\Dell\BD\g1\Baza_biblioteka.ldf',
	SIZE = 5MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 10MB
)
GO

-- ksi¹¿ki 
-- klienci
-- personel
-- wypo¿yczenia
-- autorzy