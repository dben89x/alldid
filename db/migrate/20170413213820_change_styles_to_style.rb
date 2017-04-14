class ChangeStylesToStyle < ActiveRecord::Migration[5.0]
	def change
		rename_column :endorsements, :styles_id, :style_id
	end
end
