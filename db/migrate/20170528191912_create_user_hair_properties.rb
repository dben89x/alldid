class CreateUserHairProperties < ActiveRecord::Migration[5.0]
	def change
		create_table :client_hair_properties do |t|
			t.belongs_to :profile
			t.belongs_to :hair_property
		end
		remove_column :hair_properties, :profile_id, :integer
	end
end
