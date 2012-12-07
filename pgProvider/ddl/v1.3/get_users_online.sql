﻿CREATE OR REPLACE FUNCTION get_users_online(_session_timeout integer, _appliction_name character varying) RETURNS SETOF user_record
    LANGUAGE plpgsql
    AS $$
begin

	return query
	select
		user_id,
		user_name,
		last_activity,
		created,
		email,
		approved,
		last_lockout,
		last_login,
		last_password_changed,
		password_question,
		comment
	from
		users
	where
		lower(application_name) = lower(_application_name)
		and last_activity::time + cast(_session_timeout || ' minutes' as interval) < current_timestamp;	
end;
$$;