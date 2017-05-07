class ChangeBarberStyles < ActiveRecord::Migration[5.0]
	def change
		rename_column :barber_styles, :user_id, :barber_id
		rename_column :barber_services, :user_id, :barber_id
	end
end
