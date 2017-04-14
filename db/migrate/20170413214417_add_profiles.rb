class AddProfiles < ActiveRecord::Migration[5.0]
	def change
		add_column :profiles, :current_style_id, :integer
	end
end
