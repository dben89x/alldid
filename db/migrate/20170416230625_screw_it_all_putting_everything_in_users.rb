class ScrewItAllPuttingEverythingInUsers < ActiveRecord::Migration[5.0]
	def change
		drop_table :barbers
		drop_table :clients
		remove_column :users, :actable_id, :integer
		remove_column :users, :actable_type, :string
		remove_column :users, :profile_id, :integer

		add_column :users, :hair_type, :integer
		add_column :users, :hair_width, :integer
		add_column :users, :hair_density, :integer
		add_column :users, :perfect_barber_id, :integer
		add_column :users, :current_style_id, :integer
		add_column :users, :bio, :text
		add_column :users, :hourly_rate, :integer
		add_column :users, :organization_id, :integer
	end
end
