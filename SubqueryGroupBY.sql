Use Books_En

--1. Отобразить все издательства, которые выпустили новинки после 2000 года.

SELECT DISTINCT Publisher
FROM (SELECT * 
      FROM Books_En
	  WHERE YEAR([Date]) > 2000) AS NewBooks


--2. Отобразить книги, у которых количество страниц больше, чем среднее арифметическое число страниц всех книг.

SELECT [Name],Pages
FROM Books_En 
WHERE Pages>(SELECT AVG(Pages) FROM Books_En)

--3. Отобразить тематики и сумму страниц по тематикам, учитывая при этом только книги с ценой >50.SELECT Topic, SUM(Pages) AS SumPagesFROM Books_EnWHERE Price > 50GROUP BY Topic--4. Отобразить все темы, у которых не указана категория.SELECT DISTINCT TopicFROM (SELECT *       FROM Books_En	  WHERE Category IS NULL) 	  AS BooksWithoutCategory	  WHERE Topic IS NOT NULL--5. Отобразить самую дорогую книгу издательства BHV (2 способа).SELECT TOP(1) MAX(Price) AS Price, [Name]FROM Books_EnWHERE Publisher = 'BHV Kiev' OR Publisher = 'BHV St. Petersburg'
GROUP BY [Name], Price
ORDER BY Price DESC

SELECT TOP(1) *
FROM (SELECT [Name], Price
FROM Books_En 
WHERE Publisher = 'BHV Kiev' OR Publisher = 'BHV St. Petersburg'
)
AS BooksFromBHV
ORDER BY Price DESC



--6. Отобразить издательство, у которого наибольшее количество страниц (2 способа).
SELECT TOP(1) SUM(Pages) AS SumPages, Publisher
FROM Books_En
GROUP BY Publisher
ORDER BY SUM(Pages) DESC

SELECT DISTINCT TOP(1) Publisher, (SELECT SUM(Pages) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Book.[Publisher]) AS SUMPages
FROM Books_En AS Book
ORDER BY SUMPages DESC


--7 Отобразить издательство, у которого наибольшее количество книг по программированию (2 способа).
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



--8 Определить, сколько издано книг по каждой тематике.

SELECT COUNT(*) AS [Count], Topic
FROM Books_En
GROUP BY Topic

--9 Отобразить самую дешевую книгу в каждой из следующих тематик: Программирование, Базы данных клиент-сервер, Мультимедиа.
SELECT MIN(Price), Topic
FROM Books_En
WHERE Topic IN (N'Programming', N'Multimedia', N'Database client-server data')
GROUP BY Topic

--10 Показать издательства и самую старую книгу для каждого из них.
SELECT DISTINCT  Publisher, (SELECT MIN([Date]) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Publisher] = Books.[Publisher]) AS OldestBook
FROM Books_En AS Books


--11 . Показать количество выпущенных книг-новинок по каждому издательству.

SELECT Publisher,  COUNT(*) AS NewBooks
FROM Books_En
WHERE YEAR(Date) >= 2001
GROUP BY Publisher

--12. Отобразить издательство, у которого наибольшее количество книгновинок (2 способа).

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


--13. Вывести процентный вклад каждой тематики в прайс-листе

SELECT DISTINCT Topic, ((SELECT COUNT(*) * 100 / (SELECT COUNT(Topic) FROM Books_En)
               FROM Books_En AS BooksP 
               WHERE BooksP.[Topic] = Books.[Topic])) AS [Percent]
FROM Books_En AS Books



--14. Найти среднюю цену книг, выпущенных издательствами весной 1999 года, для каждого издательства.
SELECT Publisher, AVG(Price) AS AVGPrice
FROM Books_En
WHERE Date BETWEEN '01-03-1999' AND '31-05-1999'
GROUP BY Publisher



--15. Вывести книгу, выпущенную наибольшим тиражом (2 способа).
SELECT TOP(1) [Name], MAX(Pressrun) AS Pressrun
FROM Books_En
GROUP BY [Name]
ORDER BY Pressrun DESC


SELECT DISTINCT TOP(1) [Name], (SELECT MAX(Pressrun) 
                                   FROM Books_En AS BooksP 
								   WHERE BooksP.[Name] = Books.[Name]) AS Pressrun
FROM Books_En AS Books
ORDER BY Pressrun DESC



--16. Вывести издательства, у которых число выпущенных книг превышает 5% от общего числа книг
SELECT DISTINCT Publisher, (SELECT COUNT(*) 
                            FROM Books_En AS BooksP
	                        WHERE Books.[Publisher] = BooksP.[Publisher]) AS CountBooks
FROM Books_En AS Books
WHERE (SELECT COUNT(*) 
      FROM Books_En AS BooksP
	  WHERE Books.[Publisher] = BooksP.[Publisher]) * 100 / (SELECT COUNT(*) FROM Books_En) > 5


--17 Вывести книгу, в коде которой присутствуют ровно 2 семерки.
SELECT [Name], Code
FROM Books_En
WHERE Code LIKE N'%7%7%'

--18 Вывести издательства, из букв которых можно собрать слово «лак»

SELECT Publisher 
FROM Books_En
WHERE Publisher LIKE N'[лак]'

-- 19 Вывести книги, названия которых не содержат английских букв, с числом страниц, кратным 2.
SELECT [Name]
FROM Books_En
WHERE [Name] NOT LIKE N'%[a-z]%' AND Pages % 2 = 0


--20 Вывести количество книг, у которых не указана дата выпуска.
SELECT COUNT(*) AS BooksWithoutDate
FROM Books_En
WHERE [Date] IS NULL