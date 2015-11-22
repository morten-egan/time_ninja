create or replace package time_ninja

as

	/** A package to display date and timestamps as moment strings
	* @author Morten Egan
	* @version 0.0.1
	* @project TIME_NINJA
	*/
	p_version		varchar2(50) := '0.0.1';

	/** Show how long ago from now, that something happened from a date
	* @author Morten Egan
	* @param time_in The time that something happened
	* @return moment_string The stringified version of the moment time
	*/
	function time_from (
		time_in						in				date
	)
	return varchar2;

	/** Show how long ago from now, that something happened from a timestamp
	* @author Morten Egan
	* @param time_in The time that something happened
	* @return moment_string The stringified version of the moment time
	*/
	function time_from (
		time_in						in				timestamp
	)
	return varchar2;

	/** Show how long there is to a date, from another date
	* @author Morten Egan
	* @param time_in The time to calculate time to
	* @param timef_in The time to calculate from - defaults to sysdate
	* @return varchar2 The stringified version of the moment time
	*/
	function time_to (
		time_in						in				date
		, timef_in					in				date default sysdate
	)
	return varchar2;

	/** Show how long there is to a date, from timestamps
	* @author Morten Egan
	* @param time_in The time to calculate time to
	* @return varchar2 The stringified version of the moment time
	*/
	function time_to (
		time_in						in				timestamp
		, timef_in					in				timestamp default systimestamp
	)
	return varchar2;

end time_ninja;
/