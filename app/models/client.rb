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

class Client < User

	has_many :events, inverse_of: :client
	after_save :check_for_completeness

	def check_for_completeness
		complete = first_name.present? && headline.present? && location.present? && current_style_id.present?
		if complete
			self.profile_complete = true
			self.save
		end
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

	def hair_properties(prop_type)
		self.client_hair_properties.select {|chp| chp.hair_property.type == prop_type }.first.try(:hair_property)
	end
end
