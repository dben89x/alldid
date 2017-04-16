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
#

class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	has_one :profile
	delegate :first_name, :last_name, :avatar, :current_style_id, :haircut_count, :location, :zip, :hourly_rate, to: :profile
	after_create :create_profile
	delegate :full_name, :name, to: :profile

	def create_profile
		Profile.create(user_id: self.id)
		if self.is_a? Barber
			BarberProfile.create(barber_id: self.id)
		elsif self.is_a? Client
			ClientProfile.create(client_id: self.id)
		end
	end

end
