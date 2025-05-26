--Zadanie 1:
--Suma wypożyczeń na czytelnika (ID)

SELECT readers_id, COUNT(*) AS borrowings
FROM dbo.borrowing
GROUP BY borrowing.readers_id

-- suma wypożyczeń z imieniem i nazwiskiem (left join, podzapytanie w select, podzapytanie w FROM)

-- LEFT JOIN
SELECT dane.readers_id,
	dane.first_name AS Imie,
	dane.last_name AS Nazwisko,
	COUNT(b.readers_id) AS Wypożyczone
FROM 
	dbo.readers dane
LEFT JOIN
	dbo.borrowing b ON b.readers_id = dane.readers_id
GROUP BY
	dane.first_name, dane.last_name, dane.readers_id
ORDER BY
	Wypożyczone DESC;

-- SELECT
SELECT
dane.first_name AS Imie,
	dane.last_name AS Nazwisko,
	(SELECT count(1) FROM dbo.borrowing b WHERE b.readers_id = dane.readers_id) as ile_wypozyczen
FROM
	dbo.readers dane
	ORDER BY ile_wypozyczen DESC

-- FROM
SELECT
dane.readers_id,
	dane.first_name AS Imie,
	dane.last_name AS Nazwisko,
	COALESCE (b.wypozyczenia, 0) as wypozyczenia
FROM
dbo.readers dane
LEFT JOIN
(SELECT count(1) as wypozyczenia, readers_id FROM dbo.borrowing
GROUP BY readers_id
) b ON b.readers_id = dane.readers_id
ORDER BY b.wypozyczenia DESC

-- CTE
WITH wypozyczenia AS (
SELECT count(1) as wypozyczenia, readers_id FROM dbo.borrowing
GROUP BY readers_id
)

SELECT
dane.readers_id,
	dane.first_name AS Imie,
	dane.last_name AS Nazwisko,
	COALESCE(b.wypozyczenia, 0) as wypozyczenia
FROM
dbo.readers dane
LEFT JOIN
wypozyczenia b ON b.readers_id = dane.readers_id
ORDER BY b.wypozyczenia DESC

-- Osoba z największą ilością wypożyczonych książek w miesiącu

SELECT
r.first_name, r.last_name, r.readers_id
FROM dbo.readers r
WHERE r.readers_id = (
SELECT TOP 1 b.readers_id
FROM dbo.borrowing b
GROUP BY b.readers_id, MONTH(b.[borrowing_date])
ORDER BY count(1) DESC
)

-- Ostatnia data wypożyczenia na czytelnika

SELECT max(borrowing_date), readers_id
FROM dbo.borrowing b
GROUP BY readers_id

SELECT
readers_id,
borrowing_date,
max(borrowing_date) OVER (PARTITION BY b.readers_id) as ostatnia
FROM dbo.borrowing b

--wylicz narastająco sume kar dla kazdego czytelnika w kolejnosci wypozyczen
