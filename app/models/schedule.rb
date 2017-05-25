# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  barber_id   :integer
#  day         :string
#  start_time  :datetime
#  end_time    :datetime
#  type        :string
#  date        :datetime
#  has_lunch   :boolean
#  lunch_start :datetime
#  lunch_end   :datetime
#

class Schedule < ActiveRecord::Base

end
