class AddColumnDefaultToScheduleJson < ActiveRecord::Migration[5.0]
	def change
		change_column_default :schedules, :json, '{
			"Sunday": {"start": 0, "end": 0},
			"Monday": {"start": 0, "end": 0},
			"Tuesday": {"start": 0, "end": 0},
			"Wednesday": {"start": 0, "end": 0},
			"Thursday": {"start": 0, "end": 0},
			"Friday": {"start": 0, "end": 0},
			"Saturday": {"start": 0, "end": 0}
		}'
	end
end
