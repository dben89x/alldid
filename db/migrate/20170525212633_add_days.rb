class AddDays < ActiveRecord::Migration[5.0]
	def change
		create_table :days do |t|
			t.string :name
		end

		remove_column :schedules, :day, :string
		add_column :schedules, :day_id, :integer, index: true
	end
end
