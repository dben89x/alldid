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

class Client < User
	has_many :events, inverse_of: :client
	after_save :check_for_completeness

	def active?
		true
	end

	def required_fields
		[:avatar, :first_name, :location, :current_style_id, :hair_type, :hair_width, :hair_density]
	end

	def missing_fields
		# required_fields.collect do |required_field|
		# 	required_field.
	end

	def hair_type
		hair_properties("HairType")
	end

	def hair_width
		hair_properties("HairWidth")
	end

	def hair_density
		hair_properties("HairDensity")
	end

	def current_style
		Style.find_by_id(self.current_style_id)
	end

	def hair_properties(prop_type)
		self.client_hair_properties.select {|chp| chp.hair_property.type == prop_type }.first.try(:hair_property)
	end
end
