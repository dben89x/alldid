class AddHairProfileToUser < ActiveRecord::Migration[5.0]
	def change
		create_table :client_profiles do |t|
			t.belongs_to :client
			t.integer :hair_type
			t.integer :hair_width
			t.integer :hair_density
			t.integer :perfect_barber_id
		end

		create_table :barber_profiles do |t|
			t.belongs_to :barber
			t.text :bio
		end
	end
end
