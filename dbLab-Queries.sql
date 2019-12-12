--1 insert
insert into Master (Master_Name, Master_Family, Degree, Field, Faculty_Member, Faculty_ID, Phone, Address) 
values ('فلان', 'فلانی', 'کارشناسی ارشد', 'مهندسی کامپیوتر', 1, 3, '09119999999', 'گیلان')

--2 delete
delete from Lesson where Lesson_ID = '12201002'

--3 update
update Master set Faculty_Member = 1, Degree = 'دکتری' where Master_ID = '201001006'

--4 select distinct
select distinct Address from Student

--5 where clause
select * from Lesson where Lesson_Name = 'برنامه ‌سازی پیشرفته'

--6 
select Student_Name, Student_Family, Average from Student where Average >= 17 

--7
select Lesson_Name, Lesson_Type from Lesson where Unit_Type = 'عملی'

--8 select in select
select Field_Name, Orientation from Field where Course = 'کاردانی' and Faculty_ID = (select Faculty_ID from Faculty where Faculty_Name like '%فنی%')

--9 and 
select lesson_name from lesson where Lesson_Type = 'اصلی' and Field_ID = 100

--10 or
select Field_Name, Orientation, course from Field where course = 'کاردانی' or course =  'کارشناسی ارشد'

--11
select lesson_name from lesson where Unit_Type = 'کارگاهی' or Unit_Type = 'عملی'

--12 not
select Student_Name, Student_Family, Address from Student where not Address = 'تهران'

--13
select Master_Name, Master_Family, Faculty_Member, Address from Master where not Address = 'تهران'

--14
-- method 1 : select in select
select Lesson_Name, Lesson_Type from Lesson where Lesson_Unit = 3 and (Lesson_Type = 'پایه' or Lesson_Type = 'عمومی')
	   and Field_ID = (select Field_ID from Field where Field_Name = 'مهندسی کامپیوتر' and Orientation = 'نرم افزار' and course = 'کارشناسی')

-- method 2 : inner join
select Lesson_Name, Lesson_Type from Lesson, Field where Lesson.Field_ID = Field.Field_ID and Lesson_Unit = 3 and (Lesson_Type = 'پایه' or Lesson_Type = 'عمومی')
	   and Field_Name = 'مهندسی کامپیوتر' and Orientation = 'نرم افزار' and course = 'کارشناسی'


--15
select * from Master where Faculty_ID = 3 
and not (Field = 'مهندسی کامپیوتر' or Field = 'مهندسی عمران' or Field = 'مهندسی صنایع')

--16 order by
select * from Student where Field_ID = 100 order by Student_Family asc

--17
select * from Student where Field_ID = 100 order by Average Desc

--18
select * from Student where Field_ID = 103 order by Student_Family asc, Student_Name desc

--19 top nmber or top number percent
select top 5 * from Master where Faculty_Member = 1
select top 50 percent * from Master where Faculty_ID = 3

--20 as
select Faculty_Administrator as 'رئیس دانشگاه', Faculty_Name as 'نام دانشگاه' from Faculty
select Student_Name + ' ' + Student_Family as'نام و نام خانوادگی', Address as'آدرس' from Student where Student_ID = 96100122

--21 like
select * from Student where Student_Family like '%پور%'
select * from Lesson where Lesson_Name like 'آزمایشگاه%'

--22 in
select * from Master where Field in('ریاضی', 'فیزیک')
select * from Student where Field_ID in (100, 101, 102)

--23 between
select Student_Name, Student_Family, Average from Student where Average between 12 and 15
select Student_Name, Student_Family from Student where Student_Family between 'ع' and 'ل'

--24 MIN
select min(score) from SelectionUnit 
where Identity_ID = (select Identity_ID from LessonGroup where Lesson_ID = '12262079' and Semester = 'اول' and Academic_Year = '97-98' )

--25 MAX
select min(score) as'کمترین نمره' , max(score) as'بیشترین نمره' from SelectionUnit 
where Identity_ID = (select Identity_ID from LessonGroup where Lesson_ID = '12262079' and Semester = 'اول' and Academic_Year = '97-98' )

--26 COUNT
select count(Student_ID) from Student where Entrance_Year = '1396' 
	   and Field_ID = (select Field_ID from Field where Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' )

--27 AVG , round Function
select round(AVG(Score), 2) from SelectionUnit 
where Identity_ID = (select Identity_ID from LessonGroup where Semester = 'اول' and Academic_Year = '97-98' 
					 and Lesson_ID = (select Lesson_ID from Lesson where Lesson_Name = 'زبان تخصصی'))

--28 SUM
/* Method 1 : select in select */
select sum(Lesson_Unit) from Lesson 
where Lesson_Type = 'اصلی' and  Field_ID = (select Field_ID from Field where Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' )

/* Mthod 2 : Innser Join */
select sum(Lesson_Unit) from Lesson, Field
where Lesson.Field_ID = Field.Field_ID and Lesson_Type = 'اصلی' and Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' 


--29 GROUP BY
select Lesson_Type, count(Lesson_Unit), sum(Lesson_Unit) from Lesson, Field where Field.Field_ID = Lesson.Field_ID and Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' 
group by Lesson_Type

/* rollup */
select Lesson_Type, count(Lesson_Unit), sum(Lesson_Unit) from Lesson, Field where Field.Field_ID = Lesson.Field_ID and Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' 
group by rollup(Lesson_Type)

/* grouping sets */
select Lesson_Type as'نوع درس', Unit_Type as'نوع واحد', count(Lesson_Unit) as'تعداد درس', sum(Lesson_Unit) as'مجموع واحد' from Lesson, Field where Field.Field_ID = Lesson.Field_ID and Field_Name = 'مهندسی کامپیوتر' and Course = 'کارشناسی' and Orientation = 'نرم افزار' 
group by grouping sets ((Lesson_Type, Unit_Type), (Lesson_Type, Lesson_Unit, Unit_Type))

--30 HAVING
select Lesson_Type, count(Lesson_Unit), sum(Lesson_Unit)  from Lesson where Field_ID = 100 
group by Lesson_Type having count(Lesson_Unit) > 10


--31 UNION
select 'استاد', Master_Name, Master_Family, Address from Master 
union
select 'دانشجو', Student_Name, Student_Family, Address from Student


--32 CASE
select Master_Name, Master_Family, 
	case Faculty_Member
		when 1 then 'عضو هیئت علمی'
		else 'مدرس مدعو'
	end as 'وضعیت استاد'
 from Master

--33 [JOIN]
/* 1 */
select Lesson_Name,Class_Schedule from Lesson, LessonGroup 
where Lesson.Lesson_ID = LessonGroup.Lesson_ID and Semester = 'دوم' and Entrance_Year = '1396' and Academic_Year = '97-98'


/* 2 */
select Lesson_Name, Group_Number, Class_Schedule, Exam_Schedule from LessonGroup, Lesson 
where Lesson.Lesson_ID = LessonGroup.Lesson_ID
	  and Master_ID = '201001003' and Semester = 'اول' and Academic_Year = '97-98' 


/* 3 */
select Field_Name, Course, Orientation, count(Student_ID) from Student, Field, Faculty
where Faculty.Faculty_ID = Field.Faculty_ID and Student.Field_ID = Field.Field_ID and Faculty_Name like '%فنی%'
group by Field_Name, Course, Orientation


/* 4 */
select Field_Name, Course, Orientation, count(Student_ID) from Student, Field, Faculty
where Faculty.Faculty_ID = Field.Faculty_ID and Student.Field_ID = Field.Field_ID and Faculty_Name like '%فنی%'
group by Field_Name, Course, Orientation having count(Student_ID) >= 30


/* 5 */
select Semester, Academic_Year, sum(Score * Lesson_Unit) / sum(Lesson_Unit) from SelectionUnit, Lesson, LessonGroup
where SelectionUnit.Identity_ID = LessonGroup.Identity_ID and LessonGroup.Lesson_ID = Lesson.Lesson_ID
	  and Student_ID = '96100100'
group by Semester, Academic_Year


/* 6 */
select Student.Student_ID, Student.Student_Name, Student.Student_Family from Student,SelectionUnit, LessonGroup
where Student.Student_ID = SelectionUnit.Student_ID and SelectionUnit.Identity_ID = LessonGroup.Identity_ID 
      and Lesson_ID = '12262079' and Master_ID = '201001000' and Semester = 'اول' and Academic_Year = '97-98'
order by Student_Family


/* 7 */
select Semester, Academic_Year, count(Lesson.Lesson_ID), Sum(Lesson_Unit) from Lesson, LessonGroup, SelectionUnit
where Lesson.Lesson_ID = LessonGroup.Lesson_ID and LessonGroup.Identity_ID = SelectionUnit.Identity_ID
	  and Student_ID = '96100100' 
group by Semester, Academic_Year


/* 8 */
select Student_ID, sum(SelectionUnit.Score * Lesson.Lesson_Unit)/Sum(Lesson.Lesson_Unit), Academic_Year, Semester, 
	case 
		when sum(SelectionUnit.Score * Lesson.Lesson_Unit)/Sum(Lesson.Lesson_Unit)>=12 then 'عادی'
		else 'مشروط'
	end as 'وضعیت ترم'
from SelectionUnit, Lesson, LessonGroup
where Lesson.Lesson_ID = LessonGroup.Lesson_ID and LessonGroup.Identity_ID = SelectionUnit.Identity_ID and Student_ID = '96100100'
group by Student_ID, Academic_Year, Semester
order by Academic_Year




select * from Lesson
select * from Faculty
select * from Student
select * from SelectionUnit
select * from LessonGroup where Lesson_ID = '12262079'
select * from Field
select * from Master