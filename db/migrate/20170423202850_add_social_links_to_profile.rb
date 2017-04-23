class AddSocialLinksToProfile < ActiveRecord::Migration[5.0]
	def change
		add_column :profiles, :facebook, :string
		add_column :profiles, :instagram, :string
		add_column :profiles, :twitter, :string
	end
end
