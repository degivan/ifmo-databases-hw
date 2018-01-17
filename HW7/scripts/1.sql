delete from students
	where student_id not in
		(select student_id from
			marks
			where mark < 60.0);