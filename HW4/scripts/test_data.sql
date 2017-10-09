insert into groups (group_id, group_name) values
	(1, 'M3436'),
	(2, 'M3439');
insert into students (student_id, student_name, group_id) values
	(1, 'Excellent Student', 1),
	(2, 'Bad Student', 2);
insert into courses (course_id, course_name) values
	(1, 'Databases'),
	(2, 'Philosophy');
insert into lecturers (lecturer_id, lecturer_name) values
	(1, 'Georgiy Korneev'),
	(2, 'Irina Lomova');
insert into marks (student_id, course_id, lecturer_id, score) values
	(1, 1, 1, 5),
	(1, 2, 2, 4),
	(2, 1, 1, 2),
	(2, 2, 2, 3);

