# == Schema Information
#
# Table name: user_services
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  service_id :integer
#  minutes    :integer
#

class UserService < ActiveRecord::Base
	belongs_to :profile, inverse_of: :user_services
	belongs_to :service
end
