class CreateHairProperties < ActiveRecord::Migration[5.0]
	def change
		create_table :hair_properties do |t|
			t.string :type
			t.string :name
			t.text :description
			t.belongs_to :profile
		end
		remove_column :profiles, :hair_type, :integer
		remove_column :profiles, :hair_width, :integer
		remove_column :profiles, :hair_density, :integer
	end
end
