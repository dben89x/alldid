class ChangeSubscritionUser < ActiveRecord::Migration[5.0]
	def change
		rename_column :subscriptions, :user_id_id, :user_id
	end
end
