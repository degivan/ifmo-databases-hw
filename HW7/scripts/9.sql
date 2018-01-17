create or replace function check_mark_increased() returns trigger as $$
        declare
        	stud_id int;
        	cour_id int;
        	old_mark decimal(4, 1);
        	new_mark decimal(4, 1);
        begin
            old_mark = OLD.mark;
            new_mark = NEW.mark;
            stud_id = NEW.student_id;
            cour_id = NEW.course_id;

            if (new_mark < old_mark) then
            	update marks set mark = old_mark
            		where student_id = stud_id
            		and
            		course_id = cour_id;
            end if;
            return NULL;
        end;
$$ LANGUAGE plpgsql;

create trigger mark_update after update
	on marks
	for each row
	when (OLD.mark is distinct from NEW.mark)
	execute procedure check_mark_increased();
