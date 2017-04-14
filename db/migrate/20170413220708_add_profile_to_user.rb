class AddProfileToUser < ActiveRecord::Migration[5.0]
	def change
		add_reference :users, :profile, index: true
		add_column :profiles, :first_name, :string
		remove_column :users, :first_name, :string
		add_column :profiles, :last_name, :string
		remove_column :users, :last_name, :string
		add_column :profiles, :avatar, :string
		remove_column :users, :avatar, :string
	end
end
