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

class Barber < User

	has_many :barber_styles, inverse_of: :barber
	has_many :barber_services, inverse_of: :barber
	has_many :endorsements, through: :barber_styles
	has_many :schedules
	has_many :events, inverse_of: :barber

	after_create :create_schedule

	def check_for_completeness
		self.rate.nonzero? ? super : false
	end

	def styles
		Style.where(id: self.barber_styles.pluck(:style_id).uniq)
	end

	def active?
		stripe_subscription.present? ? stripe_subscription.active? : false
	end

	def phone
		self.try(:organization).phone
	end

	def required_fields
		[:avatar, :first_name, :location, :rate, :minutes, :styles, :services]
	end

	def create_schedule
		self.schedules.create
	end
end
