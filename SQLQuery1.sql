create database TARge25

--db valimine
use master

--db kustutamine
drop database TARge25

--tabeli tegemine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male'),
(1, 'Female'),
(3, 'Unknown')

--tabeli sisu vaatamine
select * from Gender

--tehke tabel nimega Person
--id int, not null, primary key
--name nvarchar 30
--Email nvarchar 30
--GenderId int

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderID int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderID)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'cat@cat.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, null, null, 2)

--soovime näha Person tabeli sisu
select * from Person

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderID_FK
foreign key (GenderID) references Gender(ID)

--kui sisestad uue rea andmeid ja ei ole sisestanud genderID alla väärtust, siis
--see automaatselt sisestab sellele reale väärtuse 3 e mis meil on unkonwn
alter table Person
add constraint DF_Persons_GenderID
default 3 for GenderID

insert into Person (Id, Name, Email, GenderID)
values (7, 'Flash', 'f@f.com', null)

insert into Person (Id, Name, Email)
values (9, 'Black Panther', 'p@p.com')

--kustutada DF_Persons_GenderID piirang koodiga
alter table Person
drop constraint DF_Persons_GenderID

--lisame koodiga veeru
alter table Person
add Age nvarchar(10)

--lisame numbri piirangu sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kui sa tead veergude järjekorda peast,
--siis ei pea neid sisestama "Person" taha
insert into Person
values (10, 'Green Arrow', 'g@g.com', 2, 154)

--constrainti kustutamine (muuta ei saa nii)
alter table Person
drop constraint CK_Person_Age 

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 130)

--kustutame rea
delete from Person where Id = 10

--kuidas uuendada andmeid koodiga
--Id 3 uus vanus on 50

Update Person
Set Age = 50
Where Id = 3

select * from Person

--lisame person tabelisse veeru City ja nvarchar 50
alter table Person
add City nvarchar (50)

--hakkame tegema päringut kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where not City = 'Gotham'

--näitab teatud vanusega inimesi
--35, 42, 23

select * from Person where Age in (35, 42, 23)
select * from Person where Age = 35 or Age = 42 or Age = 23

--näitab teatud vanusevahemikus olevaid isikuid 22 kuni 39
select * from Person where Age > 22 and Age <39
select * from Person where Age between 22 and 39

--wildcard kasutamine
--näitab kõik g-tähega algavaid linnu
select * from Person where City like 'g%'
--näitab kõik g-tähega sisaldavaid linnasid
select * from Person where City like '%g%'
--näitab kõik g-tähega lõpevaid linnu
select * from Person where City like '%g'

--näitab kus on @ märk
select * from Person where Email like '%@%'

--näitab kellel on emailis ees ja peale @ ainult 1 täht
select * from Person where Email like '_@_.com'

--kõik kellel on nimes esimene täht w,a,s
select * from Person where Name like '[was]%'
--katusega välistab tähed
select * from Person where Name like '[^was]%'

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--kes elavad Gothamis ja New yorkis ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age > 29

--rida 149
-- 3 tund
--10.03.26

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person 
ORDER BY Name
--kuvab vastupidises järjestuses nimed
select * from Person
ORDER BY Name desc
--võtab kolm esimest rida person tabelist
select top 3 * from Person
--3 esimest aga tabeli järjestus on age ja ss name
select * from Person
--castiga saab numbreid järjestada
select top 3 Age, Name from Person order by CAST(Age as int)

--näita esimesed 50% tabelist
select top 50 percent * from Person

--kõikide isikute koondvanus
select sum(cast (age as int))
from Person

--näita kõige nooremat isikut
select min(cast(Age as int)) 
from Person

--näita kõige vanemat isikut
select max(cast(Age as int)) 
from Person

--muudame Age veeru int andmetüübiks
alter table Person
alter column Age int

--näeme konkreetses linnades olevate isikute koondvanust
Select sum(age) from person where City like 'Gotham'
Select City, sum(Age) as TotalAge from Person group by City


--kuvab esimeses reas välja toodud järjestuses ja kuvab Age TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis GenderId järgi
Select * from Person 
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab mitu rida on tabelis
select count(*) from Person

--näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku konkreetses linnas
select GenderId, City, count(GenderId) as TotalPersons, sum(age) as TotalAge
from Person where GenderId like '2'
group by GenderId, City order by GenderId

--näitab ära inimeste koondvanuse, mis on üle 41 a ja 
--kui palju neid igas linnas elab
--eristab soo järgi
Select GenderId, City, sum(age) as TotalAge, count(GenderId) as TotalPersons
from Person 
where Age > 41
group by GenderId, city order by GenderId

alter table
remove DepartmentName



--loome tabelid Employees ja Department
create table Department 
(
Id int not null primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)
create table Employees
(
Id int not null primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)
alter table Employees
add City nvarchar(50)

delete Employees

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000,1),
(7, 'Sara', 'Male', 4800,3),
(8, 'Valarie', 'Male', 5500,1),
(9, 'James', 'Male', 6500,null),
(10, 'Russell', 'Male', 8800, null)

insert into Department (Id,DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cinderella')

alter table Employees add constraint tblEmployees_DepartmentID_fk
foreign key (DepartmentId) references Department(Id)

Select Name, Gender, Salary, DepartmentName
From Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutame kõikide palgad kokku
select sum(cast(Salary as int)) as TotalSum from Employees