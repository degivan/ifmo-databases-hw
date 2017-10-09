create table lecturers (
	lecturer_id int not null,
	lecturer_name varchar(50) not null,
	primary key (lecturer_id));
create table courses (
	course_id int not null,
	course_name varchar(40) not null,
	primary key (course_id));
create table groups (
	group_id int not null,
	group_name varchar(5) not null,
	primary key (group_id));
create table students (
	student_id int not null,
	student_name varchar(50) not null,
	group_id int not null,
	primary key (student_id),
	foreign key (group_id) references groups);
create table marks (
	student_id int not null,
	course_id int not null,
	lecturer_id int not null,
	score int not null,
	primary key (student_id, course_id),
	foreign key (course_id) references courses,
	foreign key (student_id) references students,
	foreign key (lecturer_id) references lecturers);
