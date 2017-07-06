class AddLocationsAndEthnicities < ActiveRecord::Migration[5.0]
	def change
		create_table :locations do |t|
			t.string :name
		end
		create_table :ethnicities do |t|
			t.string :name
		end

		add_column :profiles, :location_id, :integer
		add_column :profiles, :ethnicity_id, :integer
	end
end
