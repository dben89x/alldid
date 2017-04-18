class AddProfilesAndRemoveUserFields < ActiveRecord::Migration[5.0]
	def change
		create_table :profiles do |t|
			t.belongs_to :user
		end

		add_reference :users, :profile, index: true

		remove_column :users, :hair_type, :integer
		remove_column :users, :hair_width, :integer
		remove_column :users, :hair_density, :integer
		remove_column :users, :perfect_barber_id, :integer
		remove_column :users, :current_style_id, :integer
		remove_column :users, :bio, :text
		remove_column :users, :hourly_rate, :integer
		remove_column :users, :organization_id, :integer

		add_column :profiles, :hair_type, :integer
		add_column :profiles, :hair_width, :integer
		add_column :profiles, :hair_density, :integer
		add_column :profiles, :perfect_barber_id, :integer
		add_column :profiles, :current_style_id, :integer
		add_column :profiles, :bio, :text
		add_column :profiles, :hourly_rate, :integer
		add_column :profiles, :organization_id, :integer

	end
end
