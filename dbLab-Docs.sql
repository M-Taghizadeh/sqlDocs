CREATE DATABASE University
DROP DATABASE University

create table Faculty(
	Faculty_ID int not null,
	Faculty_name nvarchar(30),
	Faculty_Administator nvarchar(30),
	YearOfFundatioh char(4),
	Faculty_Address nvarchar(50),
	primary key(Faculty_ID)
)

create table Field(
	Field_ID int,
	Field_Name nvarchar(30),
	Orientation nvarchar(30),
	Course nvarchar(30),
	Faculty_ID int,
	primary key(Field_ID),
	foreign key(Faculty_ID) references Faculty(Faculty_ID)
)

create table Master(
	Master_ID int identity(201001000, 1),
	Master_Name nvarchar(30),
	Master_Family nvarchar(30),
	Degree nvarchar(20),
	Field nvarchar(30),
	Faculty_Member bit,
	Faculty_ID int foreign key references Faculty(Faculty_ID),
	Phone char(11),
	Address nvarchar(50)
)
alter table Master add primary key(Master_ID)

create table Lesson (
	Lesson_ID int primary key,
	Lesson_Name nvarchar(50),
	Lesson_Unit tinyint constraint DF_LessonUnit default 3,
	Unit_Type nvarchar(10),
	Lesson_Type nvarchar(20),
	Field_ID int foreign key references Field(Field_ID)
)

create table Student(
	Student_ID int not null,
	Student_Name nvarchar(30),
	Student_Family nvarchar(30),
	Field_ID int,
	Entrance_Year char(4),
	Address nvarchar(50),
	Average float
)
alter table Student add primary key(Student_ID)
alter table Student add foreign key(Field_ID) references Field(Field_ID)
alter table Student add constraint CK_AVG check (Average >= 0 and Average <= 20)

create table LessonGroup(
	Identity_ID int not null, 
	Group_Number char(2),
	Lesson_ID int, 
	Master_ID int,
	Semester nvarchar(11),
	Academic_Year char(5),
	Entrance_Year char(4),
	Class_Schedule nvarchar(45),
	Exam_Schedule nvarchar(35),
	Capacity tinyint
)
-- define both PK and FK
alter table LessonGroup add constraint PK_ID primary key (identity_ID), 
constraint FK_LID foreign key (Lesson_ID) references Lesson(Lesson_ID),
constraint FK_MID foreign key (Master_ID) references Master(Master_ID) 

create table SelectionUnit(
	ID int identity(1, 1) primary key,
	Student_ID int foreign key references Student(Student_ID),
	Identity_ID int  foreign key references LessonGroup(identity_ID),
	Score float check(Score >= 0 and Score <= 20)
)



-- [ALTER]

--alter datatype and add null state
alter table Faculty alter column Faculty_Address nvarchar(60) not null

--rename name of tables and columns
sp_rename 'Lesson.Lesson_ID', 'LessonID', 'column'
sp_rename 'Lesson', 'Lessons'

--add and drop columns
alter table Faculty add Phone char(11), ZipCode char(10)
alter table Faculty drop column ZipCode, Phone

-- add and drop PK and FK constraint
alter table table_name add constraint PK_name primary key (column1, column2, ...)
alter table table_name add constraint FK_name1 foreign key (column1) references parent_table, constraint FK_name2 foreign key(column2) references parent_table, ...
alter table table_name drop constraint PK_name
alter table table_name drop constraint FK_name1, FK_name2,...

-- add default constraint for column
alter table table_name add constraint DF_name default 'Default_Value' for column_name
alter table table_name drop constraint DF_name

-- add and drop check for column
alter table table_name add constraint CK_name check (...)
alter table table_name drop constraint CK_name

-- [DML]
-- insert
insert into table_name (column1, column2, ...) values (value1, value2, ...)

-- delete from
delete from table_name where condition

-- truncate
truncate table table_name

-- update 
update table_name set column1 = value1, column2 = value2, ... where search_condition

-- select
select * from table_name where condition
select distinct * from table_name

-- group by 
select column_name(s), aggregate_function(column_name)
from table_name where condition group by column(s)

-- having
select column_name(s), aggregate_function(column_name)
from table_name where condition group by column_name(s)
having condition

-- union
select * from table_name1 where condition1 UNION select * from table_name2 where condition2

-- case
case expression
	when condition1 the result1
	when condition2 the result2
	when conditionN the resultN
	else result
end as 'alias'


/*[JOIN]
 - Inner Join
 - Left  Join 
 - Right Join
 - Full Join
*/

select * from Lesson
select * from Faculty
select * from Student
select * from SelectionUnit
select * from LessonGroup
select * from Field
select * from Master