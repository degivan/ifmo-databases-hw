insert into Position (position_name) values
	('HR'),
	('Java Senior Developer'),
	('Java Junior Developer'),
	('Senior QA'),
	('Team Manager'),
	('Python Senior Developer'),
	('Junior QA'),
	('System Administrator'),
	('DevOps'),
	('CEO'),
	('President');
insert into Employee (name, phone_number, e_mail, working_since, birth_date, position_id, salary, working_hours) values
	('Ivan Degtiarenko', '+111111', 'ivandeg@google.com', '27.06.17', '27.06.1997', 3, '26000.00', 24),
	('Radimir Sorokin', '+222222', 'radimirs@google.com', '01.07.17', '11.12.1996', 7, '30000.00', 24),
	('Sasha Malysheva', '+333333', 'sasham@mail.ru', '01.06.17', '10.08.1997', 11, '40000.00', 40),
	('Artem Ohanjanyan', '+444444', 'artem_oh@yahoo.com', '02.06.17', '19.11.1997', 10, '35000', 40),
	('Ilya Ivanov', '+555555', 'ilyai@bc.ru', '02.07.17', '19.11.1984', 2, '60000', 40),
	('Ilya Petrov', '+556655', 'ilyap@bc.ru', '03.07.17', '19.11.1985', 2, '60000', 40),
	('Ilya Smirnov', '+555577', 'ilyas@bc.ru', '02.09.17', '15.11.1987', 6, '60000', 40),
	('Ivan Ivanov', '+155555', 'ivani@bc.ru', '02.07.17', '19.11.1984', 4, '60000', 40),
	('Petr Ivanov', '+255555', 'petri@bc.ru', '02.07.17', '19.11.1984', 4, '60000', 40),
	('Smir Ivanov', '+355555', 'smiri@bc.ru', '02.07.17', '19.11.1995', 7, '45000', 40),
	('Alex Johnson', '+234545', 'alexj@google.com', '02.10.17', '19.01.1980', 5, '65000', 40);
insert into Team (team_name, parent_team_id) values
	('Pulse Development', null),
	('Pulse QA', 1),
	('GTX Development', null),
	('GTX QA', 3);
begin;
insert into Project (project_name, description_url, is_open_source, team_id) values
	('Pulse', 'http://www.pulse.com', true, 1),
	('GTX', 'http://www.gtx.com', false, 3);
insert into ProjectTeam (project_id, team_id) values
	(1, 1),
	(2, 3);	
commit;
insert into Vacation (employee_id, since, till, is_paid) values
	(1, '27.12.17', '28.01.18', true),
	(2, '27.12.17', '26.01.18', true);
insert into Repository (repository_name, link, is_public) values
	('pulse-main-repository', 'http://github.com/degivan/pulse', true),
	('gtx-main-repository', 'http://github.com/degivan/gtx', false);
insert into EmployeeTeam (employee_id, team_id) values
	(1, 1),
	(2, 2),
	(5, 1),
	(6, 3),
	(7, 3),
	(8, 2),
	(9, 4),
	(10, 4);
insert into ProjectRepository (repository_id, project_id) values
	(1, 1),
	(2, 2);
insert into ProjectManager (employee_id, project_id) values
	(11, 1);
insert into Version (version, release_date, is_supported, project_id) values
	('1.0', '13.09.17', false, 1),
	('1.0', '13.09.17', false, 2),
	('1.1', '13.12.17', true, 1),
	('1.1', '26.12.17', true, 2);
insert into TeamLeader (employee_id, team_id) values
	(5, 1),
	(6, 3),
	(8, 2),
	(10, 4);
insert into Place (loc_address, loc_room, desk, phone_number) values
	('SPb, Pokrysheva, 6', '234', null, '+235479'),
	('SPb, Pokrysheva, 6', '345', '1', '+894123'),
	('SPb, Pokrysheva, 6', '345', '2', '+894124'),
	('SPb, Nevskiy, 60', '101', null, '+323756');
insert into EmployeePlace (employee_id, place_id) values
	(1, 2),
	(2, 3),
	(3, 4);
begin;
insert into Meeting (topic, start_date, place_id, team_id, duration) values
	('Employee Introduction', '01.09.2017 12:30:00', 1, 1, '2:30:00'),
	('Pulse: Progress results #1', '01.10.2017 12:30:00', 4, 1, '1:00:00'),
	('Pulse: Progress results #2', '01.11.2017 12:30:00', 4, 1, '1:00:00');
insert into TeamMeeting (meeting_id, team_id) values
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(2, 1),
	(3, 1),
	(3, 2);
commit;
insert into RightToRepository (employee_id, repository_id, can_write) values
	(5, 1, true),
	(8, 1, true),
	(2, 1, false),
	(1, 1, false),
	(10, 2, true),
	(6, 2, true),
	(7, 2, false),
	(9, 2, false);
