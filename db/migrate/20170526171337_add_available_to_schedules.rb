class AddAvailableToSchedules < ActiveRecord::Migration[5.0]
	def change
		change_column_default :schedules, :json, '{
		"Sunday": {"start": 900, "end": 1700, "available": true},
		"Monday": {"start": 900, "end": 1700, "available": true},
		"Tuesday": {"start": 900, "end": 1700, "available": true},
		"Wednesday": {"start": 900, "end": 1700, "available": true},
		"Thursday": {"start": 900, "end": 1700, "available": true},
		"Friday": {"start": 900, "end": 1700, "available": true},
		"Saturday": {"start": 900, "end": 1700, "available": true}
		}'
	end
end
