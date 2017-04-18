class CreateUserStylesAndServicesAndFavorites < ActiveRecord::Migration[5.0]
	def change
		create_table :user_styles do |t|
			t.belongs_to :profile
			t.belongs_to :style
		end
		create_table :user_services do |t|
			t.belongs_to :profile
			t.belongs_to :service
		end
		create_table :user_favorites do |t|
			t.belongs_to :profile
			t.belongs_to :user
		end
	end
end
