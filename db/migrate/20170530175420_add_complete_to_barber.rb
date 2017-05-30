class AddCompleteToBarber < ActiveRecord::Migration[5.0]
	def change
		add_column :users, :profile_complete, :boolean, default: false
	end
end
