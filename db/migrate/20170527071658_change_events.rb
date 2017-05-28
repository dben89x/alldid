class ChangeEvents < ActiveRecord::Migration[5.0]
	def change
		remove_column :events, :service_id, :integer
	end
end
