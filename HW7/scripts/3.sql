delete from groups
	where group_id not in
		(select group_id from students);