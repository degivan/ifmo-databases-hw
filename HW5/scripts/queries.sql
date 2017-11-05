--1, m = 5
select distinct (student_id, student_name, group_id) from
	students 
	natural join marks 
	natural join courses
	where course_name = 'Databases'
	and 
	mark = 5; 
--2a
select distinct (student_id, student_name, group_id) from
	students
	except all
	select distinct (student_id, student_name, group_id) from
		students
		natural join marks
		natural join courses
		where course_name = 'Databases';
--2b
select distinct (student_id, student_name, group_id) from
	students
	natural join plan
	natural join courses
	where course_name = 'Databases'
	except all
	select distinct (student_id, student_name, group_id) from
		students
		natural join marks
		natural join courses
		where course_name = 'Databases';
--3, m = 1
select distinct (student_id, student_name, group_id) from
	students
	natural join marks
	natural join plan
	where lecturer_id = 1;
--4, m = 1
select student_id from
	students
	except all
	select (student_id) from
		students
		natural join marks
		natural join plan
		where lecturer_id = 1;
--5, m = 1
select student_id, student_name, group_id from
	students natural join marks
	except all
	(select student_id, student_name, group_id from
		(select * from 
		
			(select student_id, student_name, group_id from
				students natural join marks) as m_stud
			cross join
			(select course_id from
				plan
				where lecturer_id = 1) as l_courses
		) as cr_join
		except all
		select student_id, student_name, group_id from
			students 
			natural join marks
	);

--6
select student_name, course_name from
	students
	natural join plan
	natural join courses;
--7, m = 1
select (student_id, student_name, group_id) from
	students
	natural join plan
	where lecturer_id = 1;
--8
--9
--10a, m = 1
select avg(mark) from
	marks
	where student_id = 1;
--10b
select student_id, avg(mark) as average_mark from
	marks
	group by student_id;
--11
select group_id, avg(average_mark) as avg_group_mark from
	(select student_id, group_id, avg(mark) as average_mark from
		marks 
		natural join students
		group by (student_id, group_id)) as average_marks
	group by group_id;
--12
select *, b.all - d.passed as not_passed from
	(
		select count(course_id) as all, student_id from
		(
			select student_id, course_id from
				plan
				natural join
				students
		) as A
		natural left outer join 
		marks
		group by student_id
	) as B
	natural left outer join
	(
		select count(course_id) as passed, student_id from
		(
			select student_id, course_id from
				plan
				natural join
				students
		) as C
		natural left outer join 
		marks
		where mark >= 60
		group by student_id
	) as D;