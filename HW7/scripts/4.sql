create view Losers as
	select student_id, count(*) as debt from
		marks
		where mark < 60.0
		group by student_id;