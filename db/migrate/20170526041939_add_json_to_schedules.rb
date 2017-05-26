class AddJsonToSchedules < ActiveRecord::Migration[5.0]
	def change
		add_column :schedules, :json, :text
	end
end
