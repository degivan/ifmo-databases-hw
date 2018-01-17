create table Position (
	position_id serial,
	position_name varchar(100) not null,
	primary key (position_id)
);
create table Employee (
	employee_id serial not null,
	name varchar(100) not null,
	phone_number varchar(20),
	e_mail varchar(255) constraint valid_email check(e_mail LIKE '%@%.%'),
	working_since date,
	birth_date date,
	position_id serial references Position(position_id),
	salary money not null,
	working_hours int not null constraint correct_hours check(working_hours > 0 AND working_hours <= 40),
	primary key (employee_id)
);
create table Vacation (
	employee_id serial references Employee(employee_id),
	since date, --since < date
	till date,
	is_paid boolean not null,
	primary key (employee_id, since, till)
);
create table Repository (
	repository_id serial,
	repository_name varchar(100) not null,
	link varchar(255) not null,
	is_public boolean not null,
	primary key (repository_id),
	unique (link)
);
create table RightToRepository (
	employee_id serial references Employee(employee_id),
	repository_id serial references Repository(repository_id),
	can_write boolean not null
);
create table Team (
	team_id serial,
	team_name varchar(100) not null,
	parent_team_id integer default null references Team(team_id),
	primary key (team_id)
);
create table EmployeeTeam (
	employee_id serial references Employee(employee_id),
	team_id serial references Team(team_id),
	primary key (employee_id)
);
create table Project (
	project_id serial,
	project_name varchar(100) not null,
	description_url varchar(255),
	is_open_source boolean not null,
	team_id serial,
	primary key (project_id) 
);
create table ProjectTeam (
	team_id serial references Team(team_id),
	project_id serial references Project(project_id),
	primary key (team_id, project_id)
);
alter table Project add constraint project_team_fk foreign key (team_id, project_id) references ProjectTeam(team_id, project_id) 
	on delete cascade 
	on update cascade deferrable initially deferred;
create table ProjectRepository (
	project_id serial references Project(project_id),
	repository_id serial references Repository(repository_id),
	primary key (project_id, repository_id)
);
create table ProjectManager (
	employee_id serial references Employee(employee_id),
	project_id serial references Project(project_id),
	primary key (employee_id),
	unique (project_id)
);
create table Version (
	version varchar(100) constraint valid_version check(version ~ '([0-9]+.)*[0-9]+'),
	release_date date not null,
	is_supported boolean not null,
	project_id serial references Project(project_id),
	primary key (version, project_id)
);
create table TeamLeader (
	employee_id serial references Employee(employee_id),
	team_id serial references Team(team_id) not null,
	primary key (employee_id),
	unique (team_id)
);
create table Place (
	place_id serial,
	loc_address varchar(100) not null,
	loc_room varchar(20) not null,
	desk varchar(20),
	phone_number varchar(20),
	primary key (place_id)
);
create table EmployeePlace (
	employee_id serial references Employee(employee_id),
	place_id serial references Place(place_id),
	primary key (employee_id),
	unique (place_id)
);
create table Meeting (
	meeting_id serial,
	topic varchar(255) not null,
	start_date timestamp not null,
	place_id serial references Place(place_id) not null,
	team_id serial not null,
	duration interval not null,
	primary key (meeting_id)
);
create table TeamMeeting (
	meeting_id serial references Meeting(meeting_id),
	team_id serial references Team(team_id),
	primary key (meeting_id, team_id)
);
alter table Meeting add constraint team_meeting_fk foreign key (team_id, meeting_id) references TeamMeeting(team_id, meeting_id)
	on delete cascade 
	on update cascade deferrable initially deferred;
alter table Vacation add constraint correct_vacation check(since < till);
