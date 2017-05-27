schedule
	day (of week)
	barber_id
	start_time
	end_time
	type (general or specific)
	date (if specific)
	has_lunch
	lunch_start
	lunch_end

render specific schedule on dayAgenda if one exists... ajax call to retrieve schedule object for each date (via get)
if one a specific schedule doesn't exist for that date, render general schedule for that day

Please create your schedule for a general work week.

ajax call when clicked on specific day, to get schedules... render loading animation in fullCalendar area while waiting for response
	logic in api controller for which type of schedule to return
