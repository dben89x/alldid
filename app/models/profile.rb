# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  hourly_rate      :integer
#  location         :string
#  zip              :integer
#  haircut_count    :integer
#  organization_id  :integer
#  user_id          :integer
#  current_style_id :integer
#  first_name       :string
#  last_name        :string
#  avatar           :string
#

class Profile < ActiveRecord::Base
	belongs_to :user
	belongs_to :organization

	def name
		first_name || self.user.email
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
