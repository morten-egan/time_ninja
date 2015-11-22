create or replace package body time_ninja

as

	function time_from (
		time_in						in				date
	)
	return varchar2
	
	as
	
		l_months_between	number;
		l_days_between		number;
		l_hours_between		number;
		l_minutes_between	number;
		l_seconds_between	number;
		l_the_val			number;
		l_ret_val			varchar2(4000);
	
	begin
	
		dbms_application_info.set_action('time_from');

		l_months_between := months_between(sysdate, time_in);
		l_days_between := sysdate - time_in;
		l_hours_between := l_days_between * 24;
		l_minutes_between := l_hours_between * 60;
		l_seconds_between := l_minutes_between * 60;

		if l_days_between > 546 then
			l_the_val := round(l_days_between/365);
			l_ret_val := l_the_val || ' years ago';
		elsif l_days_between < 545 and l_days_between > 345 then
			l_ret_val := 'a year ago';
		elsif l_days_between < 345 and l_days_between > 45 then
			l_the_val := round(l_months_between);
			l_ret_val := l_the_val || ' months ago';
		elsif l_days_between < 45 and l_days_between > 25 then
			l_ret_val := 'a month ago';
		elsif l_hours_between > 36 then
			l_the_val := round(l_days_between);
			l_ret_val := l_the_val || ' days ago';
		elsif l_hours_between > 22 and l_hours_between < 36 then
			l_ret_val := 'a day ago';
		elsif l_minutes_between > 90 and l_hours_between < 22 then
			l_the_val := round(l_hours_between);
			l_ret_val := l_the_val || ' hours ago';
		elsif l_minutes_between > 45 and l_minutes_between < 90 then
			l_ret_val := 'an hour ago';
		elsif l_minutes_between < 45 and l_seconds_between > 90 then
			l_the_val := round(l_minutes_between);
			l_ret_val := l_the_val || ' minutes ago';
		elsif l_seconds_between < 90 and l_seconds_between > 45 then
			l_ret_val := 'a minut ago';
		else
			l_ret_val := 'a few seconds ago';
		end if;
	
		dbms_application_info.set_action(null);
	
		return l_ret_val;
	
		exception
			when others then
				dbms_application_info.set_action(null);
				raise;
	
	end time_from;

	function time_from (
		time_in						in				timestamp
	)
	return varchar2
	
	as
	
		l_ret_val			varchar2(4000);
	
	begin
	
		dbms_application_info.set_action('time_from');

		l_ret_val := time_from(to_date(to_char(time_in,'dd-mm-yyyy hh24:mi:ss'), 'dd-mm-yyyy hh24:mi:ss'));
	
		dbms_application_info.set_action(null);
	
		return l_ret_val;
	
		exception
			when others then
				dbms_application_info.set_action(null);
				raise;
	
	end time_from;

	function time_to (
		time_in						in				date
		, timef_in					in				date default sysdate
	)
	return varchar2
	
	as
	
		l_months_between	number;
		l_days_between		number;
		l_hours_between		number;
		l_minutes_between	number;
		l_seconds_between	number;
		l_the_val			number;
		l_ret_val			varchar2(4000);
	
	begin
	
		dbms_application_info.set_action('time_to');

		l_days_between := time_in - timef_in;
		l_months_between := months_between(timef_in, time_in);
		l_hours_between := l_days_between * 24;
		l_minutes_between := l_hours_between * 60;
		l_seconds_between := l_minutes_between * 60;


		if l_days_between < 0 then
			-- In the past, just run time_from on it
			l_ret_val := time_from(time_in);
		else
			if l_days_between > 546 then
				l_the_val := round(l_days_between/365);
				l_ret_val := 'in ' || l_the_val || ' years';
			elsif l_days_between < 545 and l_days_between > 345 then
				l_ret_val := 'in a year';
			elsif l_days_between < 345 and l_days_between > 45 then
				l_the_val := round(l_months_between);
				l_ret_val := 'in ' || l_the_val || ' months';
			elsif l_days_between < 45 and l_days_between > 25 then
				l_ret_val := 'in a month';
			elsif l_hours_between > 36 then
				l_the_val := round(l_days_between);
				l_ret_val := 'in ' || l_the_val || ' days';
			elsif l_hours_between > 22 and l_hours_between < 36 then
				l_ret_val := 'in a day';
			elsif l_minutes_between > 90 and l_hours_between < 22 then
				l_the_val := round(l_hours_between);
				l_ret_val := 'in ' || l_the_val || ' hours';
			elsif l_minutes_between > 45 and l_minutes_between < 90 then
				l_ret_val := 'in an hour';
			elsif l_minutes_between < 45 and l_seconds_between > 90 then
				l_the_val := round(l_minutes_between);
				l_ret_val := 'in ' || l_the_val || ' minutes';
			elsif l_seconds_between < 90 and l_seconds_between > 45 then
				l_ret_val := 'in a minute';
			else
				l_ret_val := 'in a few seconds';
			end if;
		end if;
	
		dbms_application_info.set_action(null);
	
		return l_ret_val;
	
		exception
			when others then
				dbms_application_info.set_action(null);
				raise;
	
	end time_to;

	function time_to (
		time_in						in				timestamp
		, timef_in					in				timestamp default systimestamp
	)
	return varchar2
	
	as
	
		l_ret_val			varchar2(4000);
	
	begin
	
		dbms_application_info.set_action('time_to');

		l_ret_val := time_to(to_date(to_char(time_in,'dd-mm-yyyy hh24:mi:ss'), 'dd-mm-yyyy hh24:mi:ss'), to_date(to_char(timef_in,'dd-mm-yyyy hh24:mi:ss'), 'dd-mm-yyyy hh24:mi:ss'));
	
		dbms_application_info.set_action(null);
	
		return l_ret_val;
	
		exception
			when others then
				dbms_application_info.set_action(null);
				raise;
	
	end time_to;

begin

	dbms_application_info.set_client_info('time_ninja');
	dbms_session.set_identifier('time_ninja');

end time_ninja;
/