# == Schema Information
#
# Table name: profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  hair_type         :integer
#  hair_width        :integer
#  hair_density      :integer
#  perfect_barber_id :integer
#  current_style_id  :integer
#  bio               :text
#  hourly_rate       :integer
#  organization_id   :integer
#  first_name        :string
#  last_name         :string
#  avatar            :string
#  headline          :string
#  location          :string
#  zip               :string
#

class Profile < ActiveRecord::Base

	belongs_to :user
	mount_uploader :avatar, AvatarUploader
	delegate :email, to: :user

	def name
		first_name.present? ? first_name : email
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
