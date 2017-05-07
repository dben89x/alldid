# == Schema Information
#
# Table name: barber_services
#
#  id         :integer          not null, primary key
#  barber_id  :integer
#  service_id :integer
#  rate       :integer
#  minutes    :integer
#

class BarberService < ActiveRecord::Base
	belongs_to :barber, inverse_of: :barber_services
	belongs_to :service
end
