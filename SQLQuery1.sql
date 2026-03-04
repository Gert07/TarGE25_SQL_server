create database TARge25

--db valimine
use master

--db kustutamine
drop database

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