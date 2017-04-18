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
#  profile_id             :integer
#  first_name             :string
#  last_name              :string
#  avatar                 :string
#  headline               :string
#  location               :string
#  zip                    :string
#  haircut_count          :integer
#

require 'carrierwave/orm/activerecord'
class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	belongs_to :organization
	validates_presence_of :type, :email, :password
	mount_uploader :avatar, AvatarUploader

	def name
		first_name || self.email
	end

	def full_name
		"#{first_name} #{last_name}"
	end

end
