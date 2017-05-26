class CreateUnavailableTimes < ActiveRecord::Migration[5.0]
	def change
		create_table :unavailable_times do |t|
			t.belongs_to :schedule
			t.string :description
			t.integer :start_time
			t.integer :end_time
		end

		remove_column :schedules, :start_time, :datetime
		remove_column :schedules, :end_time, :datetime
		add_column :schedules, :start_time, :integer
		add_column :schedules, :end_time, :integer
		remove_column :schedules, :has_lunch, :boolean
		remove_column :schedules, :lunch_start, :datetime
		remove_column :schedules, :lunch_end, :datetime
	end
end
