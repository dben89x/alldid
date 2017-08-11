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
#  profile_complete       :boolean          default("false")
#  barbershop_owner       :boolean          default("false")
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
	:rate, :user_styles, :user_services, :user_favorites, :current_style_id,
	:minutes, :client_hair_properties, :facebook, :instagram, :twitter, :ethnicity,
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

	def org_owner?
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
	end

	def public?
		active? and check_for_completeness
	end

	def check_for_completeness
		complete |= verify_presence(required_fields)
		self.update_column(:profile_complete, true) if complete
		complete
	end

	def required_fields
	end

	def missing_fields
		fields = required_fields.map do |required_field|
			required_field unless self.send(required_field).present?
		end
		fields.compact
	end

	def verify_presence(required_fields)
		complete = true
		required_fields.each do |required_field|
			complete = self.send(required_field).present?
			break unless complete
		end
		complete
	end

end
