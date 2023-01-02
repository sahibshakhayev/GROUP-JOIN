Use Books_En

--1. ���������� ��� ������������, ������� ��������� ������� ����� 2000 ����.

SELECT DISTINCT Publisher
FROM (SELECT * 
      FROM Books_En
	  WHERE YEAR([Date]) > 2000) AS NewBooks


--2. ���������� �����, � ������� ���������� ������� ������, ��� ������� �������������� ����� ������� ���� ����.

SELECT [Name],Pages
FROM Books_En 
WHERE Pages>(SELECT AVG(Pages) FROM Books_En)

--3. ���������� �������� � ����� ������� �� ���������, �������� ��� ���� ������ ����� � ����� >50.SELECT Topic, SUM(Pages) AS SumPagesFROM Books_EnWHERE Price > 50GROUP BY Topic--4. ���������� ��� ����, � ������� �� ������� ���������.SELECT DISTINCT TopicFROM (SELECT *       FROM Books_En	  WHERE Category IS NULL) 	  AS BooksWithoutCategory	  WHERE Topic IS NOT NULL--5. ���������� ����� ������� ����� ������������ BHV (2 �������).SELECT TOP(1) MAX(Price) AS Price, [Name]FROM Books_EnWHERE Publisher = 'BHV Kiev' OR Publisher = 'BHV St. Petersburg'
GROUP BY [Name], Price
ORDER BY Price DESC

SELECT TOP(1) *
FROM (SELECT [Name], Price
FROM Books_En 
WHERE Publisher = 'BHV Kiev' OR Publisher = 'BHV St. Petersburg'
)
AS BooksFromBHV
ORDER BY Price DESC



--6. ���������� ������������, � �������� ���������� ���������� ������� (2 �������).
SELECT TOP(1) SUM(Pages) AS SumPages, Publisher
FROM Books_En
GROUP BY Publisher
ORDER BY SUM(Pages) DESC

SELECT DISTINCT TOP(1) Publisher, (SELECT SUM(Pages) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Book.[Publisher]) AS SUMPages
FROM Books_En AS Book
ORDER BY SUMPages DESC


--7 ���������� ������������, � �������� ���������� ���������� ���� �� ���������������� (2 �������).
SELECT TOP(1) Publisher, COUNT(*) AS PBooks
FROM Books_En
WHERE Topic = N'Programming'
GROUP BY Publisher
ORDER BY PBooks DESC


SELECT DISTINCT TOP(1) Publisher, (SELECT COUNT(*) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Book.[Publisher] AND Topic = N'Programming') AS PBooks
FROM Books_En AS Book
ORDER BY PBooks DESC



--8 ����������, ������� ������ ���� �� ������ ��������.

SELECT COUNT(*) AS [Count], Topic
FROM Books_En
GROUP BY Topic

--9 ���������� ����� ������� ����� � ������ �� ��������� �������: ����������������, ���� ������ ������-������, �����������.
SELECT MIN(Price), Topic
FROM Books_En
WHERE Topic IN (N'Programming', N'Multimedia', N'Database client-server data')
GROUP BY Topic

--10 �������� ������������ � ����� ������ ����� ��� ������� �� ���.
SELECT DISTINCT  Publisher, (SELECT MIN([Date]) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Books.[Publisher]) AS OldestBook
FROM Books_En AS Books


--11 . �������� ���������� ���������� ����-������� �� ������� ������������.

SELECT Publisher,  COUNT(*) AS NewBooks
FROM Books_En
WHERE YEAR(Date) >= 2001
GROUP BY Publisher

--12. ���������� ������������, � �������� ���������� ���������� ����������� (2 �������).

SELECT  TOP(1) Publisher,  COUNT(*) AS NewBooks
FROM Books_En
WHERE YEAR(Date) >= 2001
GROUP BY Publisher
ORDER BY NewBooks DESC



SELECT DISTINCT TOP(1) Publisher, (SELECT COUNT(*) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Books.[Publisher] AND YEAR(Date) >= 2001) AS NewBooks
FROM Books_En AS Books
ORDER BY NewBooks DESC


--13. ������� ���������� ����� ������ �������� � �����-�����

SELECT DISTINCT Topic, ((SELECT COUNT(*) * 100 / (SELECT COUNT(Topic) FROM Books_En)
               FROM Books_En AS BooksP 
               WHERE BooksP.[Topic] = Books.[Topic])) AS [Percent]
FROM Books_En AS Books



--14. ����� ������� ���� ����, ���������� �������������� ������ 1999 ����, ��� ������� ������������.
SELECT Publisher, AVG(Price) AS AVGPrice
FROM Books_En
WHERE Date BETWEEN '01-03-1999' AND '31-05-1999'
GROUP BY Publisher



--15. ������� �����, ���������� ���������� ������� (2 �������).
SELECT TOP(1) [Name], MAX(Pressrun) AS Pressrun
FROM Books_En
GROUP BY [Name]
ORDER BY Pressrun DESC


SELECT DISTINCT TOP(1) [Name], (SELECT MAX(Pressrun) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Name] = Books.[Name]) AS Pressrun
FROM Books_En AS Books
ORDER BY Pressrun DESC



--16. ������� ������������, � ������� ����� ���������� ���� ��������� 5% �� ������ ����� ����
SELECT DISTINCT Publisher, (SELECT COUNT(*) 
                            FROM Books_En AS BooksP
	                        WHERE Books.[Publisher] = BooksP.[Publisher]) AS CountBooks
FROM Books_En AS Books
WHERE (SELECT COUNT(*) 
      FROM Books_En AS BooksP
	  WHERE Books.[Publisher] = BooksP.[Publisher]) * 100 / (SELECT COUNT(*) FROM Books_En) > 5


--17 ������� �����, � ���� ������� ������������ ����� 2 �������.
SELECT [Name], Code
FROM Books_En
WHERE Code LIKE N'%7%7%'

--18 ������� ������������, �� ���� ������� ����� ������� ����� ����

SELECT Publisher 
FROM Books_En
WHERE Publisher LIKE N'[���]'

-- 19 ������� �����, �������� ������� �� �������� ���������� ����, � ������ �������, ������� 2.
SELECT [Name]
FROM Books_En
WHERE [Name] NOT LIKE N'%[a-z]%' AND Pages % 2 = 0


--20 ������� ���������� ����, � ������� �� ������� ���� �������.
SELECT COUNT(*) AS BooksWithoutDate
FROM Books_En
WHERE [Date] IS NULL