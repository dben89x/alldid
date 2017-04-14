# == Schema Information
#
# Table name: barber_styles
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  skill_id :integer
#  rate     :integer
#  minutes  :integer
#

class BarberStyle < ActiveRecord::Base
	belongs_to :user
	belongs_to :skill
end
