--количество релизов от команды в этом году
select count(*) from version 
	where
	current_date - interval '1 year' < release_date
	and 
	project_id in (
		select project_id from ProjectTeam where
			team_id = 1
	);
--средняя зарплата для позиции
select avg(salary::numeric), position_id from employee
	group by position_id;
--email-ы всех сотрудников, имеющих доступ к некоторому репозиторию
select e_mail from employee where
	employee_id in 
	(
		select employee_id from RightToRepository where
			repository_id = 1
	);