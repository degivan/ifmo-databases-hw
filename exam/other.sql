create or replace function fun_ignore_empty_meeting() returns trigger as $$
declare
  is_empty boolean;
begin
  select into is_empty check_empty_meeting(new.meeting_id, new.start_date);
  if is_empty then
    return null;
  end if;
  return new;
end;
$$ language plpgsql;

create or replace function check_empty_meeting(cur_meeting integer, start_date timestamp) returns boolean as $$
declare
  meeting_employee_count integer;
begin
  select count(employee_id) into meeting_employee_count 
    from employeeteam
    natural join
    (select * from teammeeting
      where meeting_id = cur_meeting) as teams
    where employee_id not in 
      (select employee_id from vacation
        where not (start_date < till and start_date > since));
  if meeting_employee_count = 0 then
    return true;
  end if;
  return false;  
end;
$$ language plpgsql;

--drop trigger if exists ignore_empty_meeting on Meeting;
--create trigger ignore_empty_meeting before insert on Meeting
--  for each row execute procedure fun_ignore_empty_meeting();

create or replace function find_meeting_place(nstart_date timestamp, nduration interval) returns integer as $$
declare
  place_ids int[];
begin
  place_ids:= array(
  select place_id
    from Place
    where place_id not in
      (select place_id from Meeting
        where (nstart_date + nduration >= start_date and nstart_date <= start_date)
        or
        (nstart_date + nduration <= start_date + duration and nstart_date <= start_date + duration)
      )
  );
  if array_length(place_ids, 1) > 0 then
    return place_ids[1]; 
  else 
    raise exception 'No free place at the time %', nstart_date;
  end if;   
end;
$$ language plpgsql;

create or replace function unsupport_versions(supp_fin date, pr_id integer) returns void as $$
declare
begin
  update version set is_supported = false
    where release_date < supp_fin and project_id = pr_id;
end;
$$ language plpgsql;


drop view if exists PublicProjects;
create view PublicProjects as
  select project_id, repository_id from
    ProjectRepository 
    where project_id in (select project_id from Project where is_open_source = true)
    and
    repository_id in (select repository_id from Repository where is_public = true);
drop view if exists ActiveEmployees;
create view ActiveEmployees as
  select employee_id, name from Employee
    where employee_id not in (
      select employee_id from vacation where
        since < current_timestamp and current_timestamp < till
    );

create index on Version using btree (project_id);
create index on Place using btree (loc_address, loc_room, desk);
create index on Project using btree (project_name);
create index on Team using btree (team_name);
create index on Employee using btree (name);

create group admin;
create group hr;
create group manager;

revoke all on all tables in schema public from public;
grant all on all tables in schema public to admin with grant option;
grant all on Employee, EmployeeTeam, EmployeePlace to hr;
grant select on PublicProjects to public;
grant all on Meeting, TeamMeeting to manager; 


create function add_project_to_sub_team() returns trigger as $$
declare
  inheritors int[];
  iid integer;
begin
  inheritors:= get_inheritors(NEW.team_id);
  --raise exception 'inheritors, %', inheritors;
  foreach iid in array inheritors
  loop
    insert into ProjectTeam (team_id, project_id) values
      (iid, NEW.project_id);
  end loop;
  return NEW;
end;
$$ language plpgsql;

create function get_inheritors(tid integer) returns int[] as $$
declare
begin
  return array(
    with recursive inh as (
      select team_id as iid from Team where parent_team_id = tid
      union
      select parent_team_id as iid from inh a
      inner join Team on Team.parent_team_id = a.iid
    )
    select * from inh
  );
end;
$$ language plpgsql;

--create trigger add_new_team_project after insert or update on ProjectTeam
--    for each row execute procedure add_project_to_sub_team();

create view SubTeams(id, aid) as
  (
    with recursive anc(id, aid) as
      (
        select team_id, parent_team_id from Team
        union select f.team_id, a.aid
            from anc a inner join Team f
                on f.parent_team_id = a.id
      )
    select * from anc where aid is not null
  );

create view EmployeeProjects(eid, pid) as
    select employee_id, project_id from
    ProjectTeam
    natural join
    EmployeeTeam inner join subteams on employeeteam.team_id = subteams.aid
    union
    (select employee_id, project_id from 
      EmployeeTeam natural join ProjectTeam  
    );

