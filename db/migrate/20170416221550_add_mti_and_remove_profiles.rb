class AddMtiAndRemoveProfiles < ActiveRecord::Migration[5.0]
	def change
		drop_table :profiles
		drop_table :client_profiles
		drop_table :barber_profiles

		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :avatar, :string
		add_column :users, :headline, :string
		add_column :users, :location, :string
		add_column :users, :zip, :string
		add_column :users, :haircut_count, :integer

		create_table :clients do |t|
			t.integer :hair_type
			t.integer :hair_width
			t.integer :hair_density
			t.integer :perfect_barber_id
			t.integer :current_style_id
		end

		create_table :barbers do |t|
			t.text :bio
			t.integer :hourly_rate
			t.integer :organization_id
		end
	end

end
