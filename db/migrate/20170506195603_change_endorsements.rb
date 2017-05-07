class ChangeEndorsements < ActiveRecord::Migration[5.0]
	def change
		remove_column :endorsements, :barber_id, index: true
		remove_column :endorsements, :style_id, index: true
		add_column :endorsements, :barber_style_id, :integer, index: true
	end
end
