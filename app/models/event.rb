# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  barber_id  :integer
#  start_time :datetime
#  end_time   :datetime
#  notes      :text
#  style_id   :integer
#

class Event < ActiveRecord::Base
	belongs_to :client, inverse_of: :events
	belongs_to :barber, inverse_of: :events
	belongs_to :style, inverse_of: :events
end
