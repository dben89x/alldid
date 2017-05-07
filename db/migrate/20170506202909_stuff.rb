class Stuff < ActiveRecord::Migration[5.0]
	def change
		remove_column :barber_styles, :skill_id
		add_column :barber_styles, :style_id, :integer, index: true
	end
end
