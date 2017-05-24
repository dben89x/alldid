class AddBarberToOrganization < ActiveRecord::Migration[5.0]
	def change
		add_column :organizations, :user_id, :integer, index: true
		add_column :organizations, :name, :string
		add_column :organizations, :stripe_reference, :string
		add_column :organizations, :status, :string
		add_column :organizations, :created_at, :datetime
		add_column :organizations, :updated_at, :datetime
		add_column :organizations, :code, :string
		add_column :organizations, :subscription_id, :integer, index: true

		add_column :users, :stripe_id, :string
		add_column :users, :subscription_id, :integer, index: true

		create_table :subscriptions do |t|
			t.string :stripe_reference
			t.integer :subscription_status_id
			t.string :customer_reference
			t.belongs_to :user_id
			t.string :plan
		end

		create_table :memberships do |t|
			t.belongs_to :organization
			t.belongs_to :user
			t.datetime :created_at
			t.datetime :updated_at
		end
	end
end
