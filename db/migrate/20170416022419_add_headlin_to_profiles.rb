class AddHeadlinToProfiles < ActiveRecord::Migration[5.0]
	def change
		add_column :profiles, :headline, :string
	end
end
