create table Groups (
        group_id int primary key, 
        group_name name not null); 

create table Students (
        student_id int primary key, 
        student_name name not null, 
        group_id int,
        foreign key (group_id) references Groups (group_id),
        unique (student_id, group_id));

create table Courses (
        course_id int primary key, 
        course_name name not null);

create table Lecturers (
        lecturer_id int primary key, 
        lecturer_name name not null);

create table Plan (
        group_id int, 
        course_id int, 
        lecturer_id int,
        foreign key (group_id) references Groups (group_id),
        foreign key (course_id) references Courses (course_id),
        foreign key (lecturer_id) references Lecturers (lecturer_id),
        unique (group_id, course_id, lecturer_id));

create table Marks (
        student_id int, 
        course_id int, 
        mark decimal(4, 1) check ((0 <= mark) and (mark <= 100)) not null,
        primary key (student_id, course_id),
        foreign key (student_id) references Students (student_id),
        foreign key (course_id) references Courses (course_id));