class CreateStyles < ActiveRecord::Migration[5.0]
	def change
		create_table :styles do |t|
			t.string :name
			t.string :description
			t.string :url
		end

		create_table :profiles do |t|
			t.integer :hourly_rate
			t.string :location
			t.integer :zip
			t.integer :haircut_count
			t.belongs_to :organization, index: true
			t.belongs_to :user, index: true
		end

		create_table :ratings do |t|
			t.belongs_to :barber, index: true
			t.belongs_to :client, index: true
			t.text :text
			t.integer :rating
		end

		create_table :endorsements do |t|
			t.belongs_to :barber, index: true
			t.belongs_to :client, index: true
			t.belongs_to :styles, index: true
		end

		create_table :organizations do |t|
			t.string :location
			t.integer :zip
		end

		create_table :services do |t|
			t.string :name
			t.string :description
		end

		create_table :barber_styles do |t|
			t.belongs_to :user, index: true
			t.belongs_to :skill, index: true
			t.integer :rate
			t.integer :minutes
		end

		create_table :barber_services do |t|
			t.belongs_to :user, index: true
			t.belongs_to :service, index: true
			t.integer :rate
			t.integer :minutes
		end
	end
end
