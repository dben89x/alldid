# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Membership < ActiveRecord::Base
	belongs_to :organization
	belongs_to :user
	delegate :subscription, to: :organization
end
