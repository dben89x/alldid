class AddMinutesToServices < ActiveRecord::Migration[5.0]
	def change
		add_column :user_services, :minutes, :integer
	end
end
