CREATE DATABASE Library_Task_Latiph
USE Library_Task_Latiph


CREATE TABLE Authors(
Id int primary key IDENTITY,
[Name] nvarchar(70) NOT NULL, 
Surname nvarchar(70) NOT NULL 
)


CREATE TABLE Books(
	Id int primary key IDENTITY,
	[Name] nvarchar(100)  NOT NULL constraint Books_Name check(LEN([Name])>2),
	[PageCount] int NOT NULL constraint Books_PageCount check([PageCount]>10),
	AuthorId int constraint FK_Books_AuthorId foreign key (AuthorId) references Authors(Id)
)

insert into Authors
values('Letif','Hesenazde'),
('Nuri','Serinlendirici'),
('Fariz','Qulfuzlu'),
('Yami','Ichigoro'),
('Naruto','Uzumaki'),
('Tegan','Wilson')


insert into Books(AuthorId,[PageCount],[Name])
values(1,150,'LetifBook1'),
(1,225,'LetifBook2'),
(2,170,'NuriBook3'),
(2,325,'NuriBook4'),
(3,555,'FarizBook5'),
(3,425,'FarizBook6'),
(4,190,'YamiBook7'),
(4,225,'YamiBook8'),
(5,148,'NarutoBook9'),
(5,329,'NarutoBook10'),
(6,666,'TeganBook11'),
(6,999,'TeganBook12')


---Task 1-------------------------------

CREATE VIEW vw_BooksAndAuthors
as
(select b.Id, b.[Name], b.[PageCount], (a.[Name] + ' ' + a.Surname) as 'Author' from Books as b
INNER JOIN Authors as a
on b.AuthorId = a.Id)

select * from vw_BooksAndAuthors

---Task 2-----------------------

CREATE PROCEDURE usp_AuthorFullName 
@Author nvarchar(70)
as
select * from vw_BooksAndAuthors
where @Author = Author 

exec usp_AuthorFullName 'Naruto Uzumaki' --FULLNAME SEARCH



CREATE PROCEDURE usp_AuthorName 
@Name nvarchar(70)
as
select * from vw_BooksAndAuthors
where Author like '%' + @Name + '%'

exec usp_AuthorName 'Naru'  --HERF KOMBINASIYASI

----

CREATE PROCEDURE usp_AuthorName2 
@Name nvarchar(70)
as
select b.Id, b.[Name], b.[PageCount], (a.Name + ' ' + a.Surname) as 'Author' from Books as b
INNER JOIN Authors as a
on b.AuthorId = a.Id
where @Name = a.[Name]

exec usp_AuthorName2 'Letif' --ANCAQ ADA GORE AXTARIR

----

CREATE PROCEDURE usp_AuthorSurname
@Name nvarchar(70)
as
select b.Id, b.[Name], b.[PageCount], (a.Name + ' ' + a.Surname) as 'Author' from Books as b
INNER JOIN Authors as a
on b.AuthorId = a.Id
where @Name = a.[Surname]

exec usp_AuthorSurname 'Ichigoro' --ANCAQ SOYADA GORE AXTARIR


---Task 3--------------------

CREATE PROCEDURE usp_DeleteAuthor 
@Id int
as 
delete from Authors
where @Id = Id

exec usp_DeleteAuthor 1 --Delete procedure for Author

------

CREATE PROCEDURE usp_InsertAuthor  
@Name nvarchar(30),
@Surname nvarchar(30)
as
insert into Authors (Name, Surname)
values(@Name, @Surname)

exec usp_InsertAuthor 'Letif', 'Hesenzade' --Insert procedure for Author

-------

CREATE PROCEDURE usp_UpdateAuthor  
@Name nvarchar (30),
@Id int
as
update Authors
set [Name] = @Name
where Id = @Id

exec usp_UpdateAuthor @Id = 1, @Name = 'Letif' --Update procedure for Author


---Task4-----------------------


CREATE VIEW vw_Author
as
(select a.Id, (a.[Name] + ' ' + a.Surname) as 'Author', Count(b.[Name]) as 'Books Count', MAX(PageCount) as 'Max Page Count' from Books as b
FULL JOIN Authors as a
on b.AuthorId = a.Id
group by a.[Name], a.Surname, a.Id)

select * from vw_Author
------------------------------