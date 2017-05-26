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
#  stripe_id              :string
#  subscription_id        :integer
#

require 'carrierwave/orm/activerecord'
class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	has_one :profile

	has_one :membership
	delegate :organization, to: :membership
	belongs_to :subscription

	validates_presence_of :type, :email, :password
	after_create :create_profile

	delegate :first_name, :last_name, :name, :avatar, :headline, :bio, :location,
	:hourly_rate, :user_styles, :user_services, :user_favorites, :current_style_id,
	to: :profile

	def create_profile
		Profile.create(user_id: self.id)
	end

	def services
		Service.where(id: self.user_services.pluck(:service_id).uniq)
	end

	def styles
		Style.where(id: self.user_styles.pluck(:style_id).uniq)
	end

	def style
		Style.find(self.current_style_id)
	end

	def default_avatar
		avatar.file.present? ? avatar.file.url : '/assets/default-avatar.png'
	end

	def favorites
		User.where(id: self.user_favorites.pluck(:user_id).uniq)
	end

	def stripe_subscription
		if self.subscription.present?
			self.subscription
		elsif self.membership.present?
			self.membership.subscription
		else
			nil
		end
	end

	def barber_admin?
		if self.membership.present?
			self.organization.user == self
		else
			false
		end
	end

	def stripe_subscription_object
		Stripe::Subscription.retrieve(subscription.stripe_reference)
	end

	def active?
		stripe_subscription.present? ? stripe_subscription.active? : false
	end

end
