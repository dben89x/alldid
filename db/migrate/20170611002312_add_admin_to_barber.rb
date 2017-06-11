class AddAdminToBarber < ActiveRecord::Migration[5.0]
	def change
		add_column :users, :barbershop_owner, :boolean, default: false
	end
end
