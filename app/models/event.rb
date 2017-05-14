# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  barber_id  :integer
#  service_id :integer
#  start_time :datetime
#  end_time   :datetime
#  notes      :text
#

class Event < ActiveRecord::Base

end
