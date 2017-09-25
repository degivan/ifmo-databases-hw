create table groups (
	group_id int not null,
	name varchar(5) not null,
	primary key(group_id));
create table students (
	student_id int not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	group_id int,
	primary key(student_id),
	foreign key(group_id) references groups(group_id));
create table subjects (
	subject_id int not null,
	name varchar(40) not null,
	teacher_id int,
	primary key(subject_id));
create table teachers (
	teacher_id int not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	primary key(teacher_id));
alter table subjects add constraint teacher_fk foreign key(teacher_id) references teachers(teacher_id);                                                           
create table marks (
	student_id int not null,
	subject_id int not null,
	score int not null,
	primary key(student_id, subject_id),
	foreign key(student_id) references students(student_id),
	foreign key(subject_id) references subjects(subject_id));
