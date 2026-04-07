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

--miinimum palga saaja
select min(cast(Salary as int)) as TotalSum from Employees

--teeme left join päringu 
select Location, sum(cast(salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --ühe kuu palgafond linnade lõikes

--teeme veeru nimega city Employees tabelisse
--nvarchar 30 
--mul juba olemas

select * from Employees

--peale selecti tulevad veergude nimed 
select City, Gender, sum(cast(salary as int)) as TotalSalary
--tabelist nimega employees ja mis on grupitatud City ja Gender järgi
from Employees group by City, Gender
--order by järjestab tähestikulises järjekorras linnad
--aga kui on nullid, siis need tulevad kõige ette
order by city 

--loeb mitu rida on tabelis
--* asemele võib panna ka veeru nime, loeb ainult väärtusi, mis ei ole "null"
select count(*) from Employees

--mitu töötajat on soo ja linna kaupa
select Gender, City, sum(cast(salary as int)) as TotalSalary,
count(Id) as TotalEmployees
from Employees group by Gender, City

--kuvab ainult vastava soo kaupa
select Gender, City, sum(cast(salary as int)) as TotalSalary,
count(Id) as TotalEmployees
from Employees 
where Gender = 'Female' 
group by Gender, City

--sama tulemuse, aga kasutage having klauslit
select Gender, City, sum(cast(salary as int)) as TotalSalary,
count(Id) as TotalEmployees
from Employees 
group by Gender, City 
having Gender = 'Male'

--näitab meile ainult need töötajad, kellel on palga summa üle 4000
Select *
From Employees
where Salary > 4000

--havinguga sama asi mis üleval
Select City, sum(cast(Salary as int)) as TotalSalary, Name,
count(Id) as TotalEmployees
From Employees
group by Salary, City, Name
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1) primary key,
value nvarchar(30)
)

insert into Test1 values('x')
select * from Test1

--- kustutame veeru nimega City Employees tabelist
alter table Employees
drop column City

-- inner join 
-- kuvab neid, kellel on DepartmentName all olemas väärtus 
Select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--teeme left join
--kuvab kõik read Employee tabelist,
--aga DepartmentName näitab ainult siis, kui on olemas
--kui DepartmentId on "null", siis DepartmentName näitab "null"
Select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--right join
--kuvab read mis on vastavuses DepartmentName-iga
Select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

--full join ja outer join on sama asi, teeb left ja right joini kokku.
--kuvab kõik read mõlemast tabelist,
-- aga kui vastet ei ole, siis näitab "null"
Select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id

--cross join
--kuvab kõik read mõlemast tabelist, aga ei võta aluseks mingit veergu,
-- vaid lihtsalt kombineerib kõik read omavahel
--kasutatakse harva, kui on vaja kombineerida kõiki
--võimalikke kombinatsioone kahe tabeli vahel, siis võib kasutada caross joini
Select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--päringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinConditions
--päringu sisu

--kuidas kuvada ainult need isikud, kellel on DepartmentName Null
-- võib kasutada nii "left" joini kui ka "full" joini
Select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where DepartmentName is null

--õpetaja moodus, saab kasutada ainult left joini
Select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where DepartmentId is null

--kuidas saame department tabelis rea, kus on NULL tulemused Empolyee tabeli ridadel
Select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.Id is null

--full join 
--kus on vaja kuvada kõik read mõlemast tabelist,
--millel ei ole vastet
Select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.Id is null or Department.Id is null

--kuidas muuta tabelite nimesi koodiga
--sp = store procedure, originaal value ja asendatav value
sp_rename 'Empolyees1', 'Employees'

--kasutame Employees tabeli asemel lühendit E ja M
--aga enne seda lisame uue veeru nimega ManagerId ja see on int
alter table Employees
add ManagerId int

--antud juhul E on Employees tabeli lühend ja M
--on samuti Employee tabeli lühend aga me kasutame
--seda, et näidata, et see on manageri tabel
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--inner join ja kasutame lühendeid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join ja kasutame lühendeid
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select FirstName, LastName, Phone, AddressID, AddressType
from SalesLT.CustomerAddress
left join SalesLT.Customer
on SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID

--teha päring, kus kasutate ProductModelit ja Product tabelit,
--et näha, millised tooted on millise mudeliga seotud
select P.Name as Product, PM.Name as ProductModel
from SalesLT.Product P
left join SalesLT.ProductModel PM
on PM.ProductModelId = p.ProductModelId


--4 tund -- 31.03.26


select isnull('Sinu Nimi', 'No Manager') as Manager

select COALESCE(null, 'No Manager') as Manager

--Neil kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.name, 'No Manager')as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--kui Expression on õige, siis paneb väärtuse, mida soovid või 
--vastasel juhul paneb No Manager teksti

--case when Expression Then '' else '' end

--teeme päringu kus kasutame case-i
--tuleb kasutada ka left joini

select E.Name as Employee, case when M.name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelise uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

--muudame veeru nime koodiga
sp_rename 'Employees.MiddleName', 'MiddleName'
select * from Employees

update Employees
Set MiddleName = 'Nick', LastName = 'Jones'
Where Id = 1;
update Employees
Set MiddleName = null, LastName = 'Anderson'
Where Id = 2;

--igas reast võtab esimesena mitte nulli väärtuse ja paneb Name veergu
--kasutada coalesce
Select Id, coalesce(FirstName, MiddleName, LastName) as Name
From Employees

create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

Insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

Insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutate union all
--liidab kõik kokku
select * from IndianCustomers
Union ALL
Select Id, Name, Email from UKCustomers

--võtab kordused välja
select * from IndianCustomers
Union
Select Id, Name, Email from UKCustomers

--kuidas tulemust sorteerida nimede järgi
--kasutada union all

select * from IndianCustomers
Union ALL
Select Id, Name, Email from UKCustomers
Order by Name

--stored procedure
--salvestatud protseduurid on SQL-i koodid, mis on
--salvestatud andmebaasis ja mida saab käivitada
--et teha mingi kindel töö ära
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--nüüd saame kasutada spGetEmployees-i
spGetEmployees
exec spGetEmployees
execute spGetEmployees

----
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees 
	where Gender = @Gender and DepartmentId = @DepartmentId
end
--võib märkida ära parameetrite nimed
spGetEmployeesByGenderAndDepartment @gender = 'Male', @departmentId = 1
--ei ole kohustuslik
spGetEmployeesByGenderAndDepartment 'Male', 1
--info sp kohta
sp_helptext spGetEmployeesByGenderAndDepartment

--muudame sp-d ja lisame võtme
alter procedure spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int
with encryption --paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employees
	where Gender = @Gender and DepartmentId = @DepartmentId
end


create proc spGetEmployeeCountByGender
@Gender nvarchar(10),
--output parameeter, mis võimaldab meil salvestadada arvutuse tulemuse
--ja kasutada seda väljaspool protseduuri
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees 
	where Gender = @Gender
end

--annab tulemuse kus loendab ära nõuetele vastavad read
declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

--näitab ära, et mitu rida vastab nõuetele 
--out on parameeter, mis võimaldab meil salvestada protseduuri
declare @totalcount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out,
@Gender = 'male' 
print @TotalCount

--sp sisu vaatamine (muutujad ja üles ehitus)
sp_helptext spGetEmployeeCountByGender
--annab koos tabeliga
sp_help spGetEmployeeCountByGender

--vaatame millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabelit sp_depends-iga
sp_depends Employees

----
create proc spGetNameById
@Id int,
@Name nvarchar(25) output
as Begin
	select @Id = Id, @Name = FirstName from Employees
end

--tahame näha kogu tabelite ridade arvu
--counti kasutada

create proc spGetTableRowsEasy
as begin 
	select count(Id) from Employees
end

spGetTableRowsEasy


-----
create proc spGetTableRows
@Rows int output
as begin 
	select @Rows = count(Id) from Employees
end


drop procedure spGetTableRows
--saame teada, et mitu rida on tabelis
declare @Rows int
execute spGetTableRows @Rows output
select @Rows

-------
--Mis id all on keegi nime järgi
create proc spGetIdByName
@Id int,
@FirstName nvarchar(25) output
as Begin
	select @FirstName = FirstName from Employees where @Id = Id
end

--annab tulemuse, kus Id 1 real on keegi koos nimega
declare @FirstName nvarchar(30)
execute spGetIdByName 9, @FirstName output
print 'Name of the Employee = ' + @FirstName

----
declare @Name nvarchar(30)
execute spGetNameById 2, @Name output
print 'Name of the Employee = ' + @Name
--ei anna tulemust, sest sp-s on loogika viga
--sp-s on viga, sest @Id on parameeter,
--mis on mõeldud selleks, et me saaksime sisestada id-d
--ja saada nime, aga sp-s on loogika viga, sest see
--üritab määrata @Id väärtuseks Id veeru väärtuse, mis on vale


-- 5 tund -- 07.04.2026


declare @Name nvarchar(30)
execute spGetNameById2, @Name out
print 'Name of the Employee = ' + @Name

sp_help spGetNameById

--eemaldan returni, return saab tagastada ainult INT andmetüüpi
alter proc spGetNameById2
@Id int
as begin
	select FirstName from Employees where Id = @Id
end

declare @EmployeeName nvarchar(30)
execute @EmployeeName = spGetNameById2 3
print 'Name of the Employee = ' + @EmployeeName
--return annab ainult INT tüüpi väärtust

--sisseehitatud string funktsioonid
--see konverteerib ASCII tähe väärtuse numbriks
select ascii('A')
--kuvab A-tähe
select char(230)

--prindime kogu tähestiku välja A-st Z-ni
--kasutame while tsüklit

declare @start int
set @start = 65

while @start <= ascii('Z')
begin
	print char(@start)
	set @start = @start + 1
end

--eemaldame tühjad kohad sulgudes
select ltrim('      hello')

--tühikute eemaldamine sõnast kas vakult või paremalt, või mõlemad (ltrim, rtrim, trim)
select trim(FirstName) as Firstname, MiddleName, LastName from Employees

--uppercase ja lowercase (upper, lower)
--reverse kkerab ringi tähed (reverse)
select reverse(upper(FirstName)) as Firstname from Employees

--(left) võtab stringi vasakult poolt (n) arv tähti
select left('ABCDEF', 6)
--(right) võtab stringi paremalt poolt (n) arv tähti
select right('ABCDEF', 2)

--kuvab (@) tähemärgi asetust (n) stringis
select CHARINDEX('@', 'sara@aaa.com')

--kuvab (x) stringis alates (n) tähest nii mitu (n) tähemärki
select SUBSTRING('leo@bbb.com', 5, 2)

--@ märgist kuvab kolm tähemärki. Viimase nr saab määrata pikkust
select SUBSTRING('leo@bbb.com', charindex('@', 'leo@bbb.com') +1 , 3)

--peale @-märki reguleerin tähemärkida pikkuse näitamist
select SUBSTRING('leo@bbb.com', charindex('@', 'leo@bbb.com') +2, len('leo@bbb.com') -CHARINDEX('@', 'leo@bbb.com'))

--saame teada domeeninimed emailides
--kasutame Employees tabelit ja substringi, len ja charindexi

select SUBSTRING(Email, CHARINDEX('@', Email) +1, len(Email) -CHARINDEX('@', Email)) from Person

alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees
set Email = 'Tom@aaa.com' Where Id = 1
update Employees
set Email = 'Pam@bbb.com' where Id = 2
update Employees
set Email = 'John@aaa.com' where Id = 3
update Employees
set Email = 'Sam@bbb.com' where Id = 4
update Employees
set Email = 'Todd@bbb.com' where Id = 5
update Employees
set Email = 'Ben@ccc.com' where Id = 6
update Employees
set Email = 'Sara@ccc.com' where Id = 7
update Employees
set Email = 'Valerie@aaa.com' where Id = 8
update Employees
set Email = 'James@bbb.com' where Id = 9
update Employees
set Email = 'Russell@bbb.com' where Id = 10

--lisame *-märgi alates teatud kohast
select FirstName, LastName, 
	SUBSTRING(Email, 1, 2) + replicate('*', 5) +
	--peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, charindex('@', Email), len(Email)
	- CHARINDEX('@', Email) + 1) as MaskedEmail
	--kuni @-märgini paneb tärnif ja siis jätkab emaili näitamist
	--on dünaamiline, sest kui emaili pikkuson erinev, siis paneb vastavalt tärne
from Employees

--kolm korda näitab stringis olevat väärtust 
select replicate('Hello', 3)

--kuidas sisestada tühikut kahe nime vahele
select space(5)

--võtame tabelist Employees ja kuvame eesnime ja perekonnanime vahel tühikut
select (FirstName + space(1) + LastName) as FullName from Employees

--PATINDEX
--sama, mis charindex aga patindex võimaldab kasutada wildcardi
--kasutame tabelit Employees ja leiame kõik read, kus emaili lõpus on aaa.com


select Email, patindex('%@aaa.com%', Email) as Position from Employees 
where PATINDEX('%@aaa.com%', Email) > 0
--leiame kõik read, kus email lõpus on aaa.com või bbb.com

--asendame emaili lõpus olevad domeeninimed .com asemel .net, kasutage replace funktsiooni
select REPLACE(Email,'.com', '.net') from Employees

--soovin asendada peale esimest märki olevad tähed tärnidega (5)
select FirstName, LastName, Email,
	stuff(Email,2,3,'*****') as StuffedEmail
from Employees

--ajaga seotud andmetüübid
create table DateTest 
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTest

--sinu masina kellaeg

select getdate() as CurrentDateTime

insert into DateTest
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

update DateTest set c_datetimeoffset = '2026-04-07 12:00:08.9866667 +02:00'
where c_datetimeoffset = '2026-04-07 17:13:08.9866667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja päring
select SYSDATETIME(), 'SYSDATETIME' --veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSTEMDATETIMEOFFSET' --täpne aja ja ajavööndi päring
select GETUTCDATE(), 'GETUTCDATE' --UTC aja päring

select ISDATE('2023-03-04') --tagastab 1, sest on kuupäev
select ISDATE(GETDATE()) --tagastab 1, sest see on kuupäev
select ISDATE('2026-04-07 17:13:08.9866667') -- tagastab 0, kuna max 3 komakohta
select DAY(getdate()) --annab tänase päeva numbri
select DAY('01/23/2026') --annab stringis oleva kp ja õige formaat peab olema
select MONTH(getdate()) --sama mis päevaga
select YEAR(getdate()) --sama mis päevaga