class CreateSchedules < ActiveRecord::Migration[5.0]
	def change
		create_table :schedules do |t|
			t.belongs_to :barber

		end
		create_table :unavailable_day do |t|
			t.belongs_to :schedule
			t.datetime :date
		end
		create_table :events do |t|
			t.belongs_to :client
			t.belongs_to :barber
			t.belongs_to :service
			t.datetime :start_time
			t.datetime :end_time
			t.text :notes
		end
		add_column :services, :minutes, :integer
	end
end
