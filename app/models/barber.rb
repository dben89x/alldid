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

class Barber < User

	has_many :barber_styles, inverse_of: :barber
	has_many :barber_services, inverse_of: :barber
	has_many :endorsements, through: :barber_styles
	has_many :schedules
	has_many :events, inverse_of: :barber

	after_create :create_schedule
	after_save :check_for_completeness

	def check_for_completeness
		complete = minutes.present? && rate.present? && first_name.present? && headline.present? && location.present?
		if complete
			self.update_column(:profile_complete, true)
		end
	end

	def styles
		Style.where(id: self.barber_styles.pluck(:style_id).uniq)
	end

	def create_schedule
		self.schedules.create
	end
end
