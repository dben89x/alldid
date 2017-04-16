class AddProfileToSubclasses < ActiveRecord::Migration[5.0]
  def change
		add_column :barber_profiles, :profile_id, :integer, index: true
		add_column :client_profiles, :profile_id, :integer, index: true
  end
end
