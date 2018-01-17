delete from students
	where student_id in
		(select student_id from
			(select student_id, count(*) as debt from
				marks
				where mark < 60.0
				group by student_id)
			as debts
		where debt >= 3);