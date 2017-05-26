# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  barber_id  :integer
#  type       :string
#  date       :datetime
#  day_id     :integer
#  start_time :integer
#  end_time   :integer
#  json       :text
#

class Schedule < ActiveRecord::Base
	belongs_to :barber
	
	serialize :json
end
