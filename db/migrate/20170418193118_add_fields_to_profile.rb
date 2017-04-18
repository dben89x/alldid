class AddFieldsToProfile < ActiveRecord::Migration[5.0]
	def change
		add_column :profiles, :first_name, :string
		add_column :profiles, :last_name, :string
		add_column :profiles, :avatar, :string
		add_column :profiles, :headline, :string
		add_column :profiles, :location, :string
		add_column :profiles, :zip, :string

		remove_column :users, :first_name, :string
		remove_column :users, :last_name, :string
		remove_column :users, :avatar, :string
		remove_column :users, :headline, :string
		remove_column :users, :location, :string
		remove_column :users, :zip, :string
	end
end
