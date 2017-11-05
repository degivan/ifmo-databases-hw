--1, n = 60.0
select * from
	students
	where student_id in
		(select student_id from
			marks
			where mark = 60.0 and
			course_id in
				(select course_id from
					courses
					where course_name = 'Базы данных'));
--2a
select * from
	students
	where student_id not in
		(select student_id from
			marks
			where course_id in
				(select course_id from
					courses
					where course_name = 'Базы данных'));
--2b
select * from
	students
	where student_id not in
		(select student_id from
			marks
			where course_id in
				(select course_id from
					courses
					where course_name = 'Базы данных'))
	except all 
	select * from 
		students
		where group_id not in
			(select group_id from
				plan
				where course_id in
					(select course_id from
						courses
						where course_name = 'Базы данных'));
--3, n = 1
select * from
	students
	where student_id in
		(select student_id from
			marks
			where course_id in
				(select course_id from
					plan
					where lecturer_id = 1));
--4, n = 1
select student_id from
	students
	where student_id not in
		(select student_id from
			marks
			where course_id in
				(select course_id from
					plan
					where lecturer_id = 1));
--5, n = 1
--6
select student_name, course_name from
	students
	natural join courses
	where (group_id, course_id) in
		(select group_id, course_id from
			plan);
--7, n = 1
select * from
	students
	where group_id in
		(select group_id from
			plan
			where lecturer_id = 1);
--8
--9