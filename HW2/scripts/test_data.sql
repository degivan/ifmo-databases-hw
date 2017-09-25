insert into groups (group_id, name) values
	(1, 'M3436'),
	(2, 'M3439');
insert into students (student_id, first_name, last_name, group_id)
	values
	(1, 'Ivan', 'Degtiarenko', 1),
	(2, 'Another', 'Human Being', 2);
insert into teachers (teacher_id, first_name, last_name) values
	(1, 'Great', 'Teacher'),
	(2, 'The greatest', 'Teacher');
insert into subjects (subject_id, name, teacher_id)
	values
	(1, 'Subject 1', 1),
	(2, 'Subject 2', 2);
insert into marks (student_id, subject_id, score)
	values
	(1, 1, 5),
	(1, 2, 4),
	(2, 1, 5),
	(2, 2, 4);