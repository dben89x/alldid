class ChangeHourlyRate < ActiveRecord::Migration[5.0]
	def change
		rename_column :profiles, :hourly_rate, :rate
		change_column_default :profiles, :rate, 0
	end
end
