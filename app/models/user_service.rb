# == Schema Information
#
# Table name: user_services
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  service_id :integer
#

class UserService < ActiveRecord::Base
	belongs_to :profile
	belongs_to :service
end
