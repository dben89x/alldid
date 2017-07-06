# == Schema Information
#
# Table name: profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  perfect_barber_id :integer
#  current_style_id  :integer
#  bio               :text
#  rate              :integer          default("0")
#  organization_id   :integer
#  first_name        :string
#  last_name         :string
#  avatar            :string
#  headline          :string
#  location          :string
#  zip               :string
#  facebook          :string
#  instagram         :string
#  twitter           :string
#  minutes           :integer          default("0")
#

class Profile < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	belongs_to :user
	has_many :user_styles, inverse_of: :profile
	has_many :user_services, inverse_of: :profile
	has_many :user_favorites, inverse_of: :profile
	has_many :client_hair_properties, inverse_of: :profile
	belongs_to :location
	belongs_to :ethnicity

	validates_length_of :headline, minimum: 5, maximum: 120, allow_blank: true

	delegate :email, to: :user

	def name
		first_name.present? ? first_name : email
	end

	def current_style_name
		if current_style
			Style.find(self.current_style_id).name
		else
			nil
		end
	end

	def current_style
		Style.find_by_id(self.current_style_id)
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
