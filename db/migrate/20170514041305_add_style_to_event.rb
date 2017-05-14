class AddStyleToEvent < ActiveRecord::Migration[5.0]
	def change
		add_column :events, :style_id, :integer, index: true
	end
end
