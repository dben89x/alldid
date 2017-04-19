# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#  haircut_count          :integer
#  profile_id             :integer
#

require 'carrierwave/orm/activerecord'
class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	belongs_to :organization
	has_one :profile

	validates_presence_of :type, :email, :password
	after_create :create_profile

	delegate :name, to: :profile
	delegate :avatar, to: :profile
	delegate :user_styles, to: :profile
	delegate :user_services, to: :profile
	delegate :user_favorites, to: :profile

	def create_profile
		Profile.create(user_id: self.id)
	end

	def services
		Service.where(id: self.user_services.pluck(:service_id).uniq)
	end

	def styles
		Style.where(id: self.user_styles.pluck(:style_id).uniq)
	end

	def favorites
		User.where(id: self.user_favorites.pluck(:user_id).uniq)
	end

end
