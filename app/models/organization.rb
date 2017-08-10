# == Schema Information
#
# Table name: organizations
#
#  id               :integer          not null, primary key
#  location         :string
#  zip              :integer
#  user_id          :integer
#  name             :string
#  stripe_reference :string
#  status           :string
#  created_at       :datetime
#  updated_at       :datetime
#  code             :string
#  subscription_id  :integer
#  phone            :string
#

class Organization < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships
	after_create :create_code
	belongs_to :user
	belongs_to :subscription

	def create_code
		self.code = SecureRandom.random_number(36**12).to_s(36).rjust(12, "0")
		self.save
	end

	def has_room?
		member_count < max_members
	end

	def max_members
		Float::INFINITY
	end

	def member_count
		self.memberships.count
	end

	def active?

	end
end
