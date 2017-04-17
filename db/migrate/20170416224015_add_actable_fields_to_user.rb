class AddActableFieldsToUser < ActiveRecord::Migration[5.0]
	def change
		add_column :users, :actable_id, :integer
		add_column :users, :actable_type, :string
	end
end
