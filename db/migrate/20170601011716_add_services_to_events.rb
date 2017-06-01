class AddServicesToEvents < ActiveRecord::Migration[5.0]
	def change
		add_column :events, :services, :string
	end
end
