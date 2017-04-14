# == Schema Information
#
# Table name: barber_profiles
#
#  id        :integer          not null, primary key
#  barber_id :integer
#  bio       :text
#

class BarberProfile < ActiveRecord::Base
	belongs_to :barber

end
