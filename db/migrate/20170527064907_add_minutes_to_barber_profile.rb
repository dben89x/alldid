class AddMinutesToBarberProfile < ActiveRecord::Migration[5.0]
	def change
		add_column :profiles, :minutes, :integer, default: 0
	end
end
