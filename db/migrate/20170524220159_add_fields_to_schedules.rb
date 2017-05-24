class AddFieldsToSchedules < ActiveRecord::Migration[5.0]
	def change
		add_column :schedules, :day , :string
		add_column :schedules, :start_time, :datetime
		add_column :schedules, :end_time, :datetime
		add_column :schedules, :type , :string
		add_column :schedules, :date , :datetime
		add_column :schedules, :has_lunch, :boolean
		add_column :schedules, :lunch_start, :datetime
		add_column :schedules, :lunch_end, :datetime

		drop_table :unavailable_day

		create_table :unavailable_days do |t|
			t.string :description
			t.datetime :date
			t.belongs_to :barber
		end
	end
end
