# == Schema Information
#
# Table name: barber_services
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  service_id :integer
#  rate       :integer
#  minutes    :integer
#

class BarberService < ActiveRecord::Base
	belongs_to :user
	belongs_to :service
end
