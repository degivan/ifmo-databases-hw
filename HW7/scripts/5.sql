create table LoserT (
	student_id int primary key,
	debt int not null,
	foreign key (student_id) references students(student_id)
);

create or replace function update_loser_table() returns trigger as $$
        declare
        	stud_id int;
        	old_mark decimal(4, 1);
        	new_mark decimal(4, 1);
        begin
            if (tg_op = 'update') then
            	stud_id = NEW.student_id;
            	old_mark = OLD.mark;
            	new_mark = NEW.mark;

            	if (old_mark < 60.0 and new_mark > 60.0) then
            		update LoserT set debt = debt - 1
            			where student_id = stud_id;
            	end if;
            elsif (tg_op = 'insert') then
            	stud_id = NEW.student_id;
            	new_mark = NEW.mark;

            	if (new_mark < 60.0) then
            		insert into LoserT (student_id, debt) values (stud_id, 1)
            			on conflict(debt) do
            				update set debt = debt + 1
            					where student_id = stud_id;	
            	end if;
            end if;
            return NULL;
        end;
$$ LANGUAGE plpgsql;

create trigger loser_update after update or insert
	on marks
	for each row
	execute procedure update_loser_table();