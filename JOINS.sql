Use Library
--1. Books -> Press
SELECT Books.Id AS BookID, Books.[Name] AS BookName, Press.[Name]  AS Press
FROM Books JOIN Press 
ON Books.Id_Press = Press.Id


-- 2. Books -> Authors
SELECT Books.Id AS BookID, Books.[Name] AS BookName, (Authors.FirstName + ' ' + Authors.LastName)  AS Author
FROM Books JOIN Authors
ON Books.Id_Author = Authors.Id

-- 3. Books -> Categories
SELECT Books.Id AS BookID, Books.[Name] AS BookName, Categories.[Name] AS Category
FROM Books JOIN Categories
ON Books.Id_Category = Categories.Id


--4. Books -> Press -> Authors
SELECT Books.Id AS BookID, Books.[Name] AS BookName, Press.[Name] AS Press, Authors.FirstName + ' ' + Authors.LastName AS Author
FROM Books 
JOIN Press 
ON Books.Id_Press = Press.Id
JOIN Authors
ON Books.Id_Author = Authors.Id



-- 5. Students -> Faculties

SELECT Students.Id AS StudentID, Students.FirstName + ' ' + Students.LastName AS StudentName,  F.[Name] AS Faculity
FROM Students
JOIN Groups AS G
ON Students.Id_Group = G.Id
JOIN Faculties AS F
ON G.Id_Faculty = F.Id


-- 6. Students -> Books

SELECT Students.Id AS StudentID, Students.FirstName + ' ' + Students.LastName AS StudentName,  B.[Name] AS OrderedBook
FROM Students
JOIN S_Cards AS SC
ON Students.Id = SC.Id_Student
JOIN Books AS B
ON SC.Id_Book = B.Id

-- 7. Teachers -> Books


SELECT Teachers.Id AS TeacherID, Teachers.FirstName + ' ' + Teachers.LastName AS TeacherName,  B.[Name] AS OrderedBook
FROM Teachers
JOIN T_Cards AS TC
ON Teachers.Id = TC.Id_Teacher
JOIN Books AS B
ON TC.Id_Book = B.Id
