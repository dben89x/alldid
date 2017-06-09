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
#  json       :text             default("{\"Sunday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Monday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Tuesday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Wednesday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Thursday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Friday\": {\"start\": 900, \"end\": 1700, \"available\": true}, \"Saturday\": {\"start\": 900, \"end\": 1700, \"available\": true}}")
#

class Schedule < ActiveRecord::Base
	belongs_to :barber

	after_save :parse_json
	serialize :json

	def parse_json
		self.update_column('json', JSON.parse(self.json).to_json)
	end

	def get_json
		JSON.parse(self.json)
	end
end
