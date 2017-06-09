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
#  json       :text             default("{\n\t\t\"Sunday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Monday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Tuesday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Wednesday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Thursday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Friday\": {\"start\": 900, \"end\": 1700, \"available\": true},\n\t\t\"Saturday\": {\"start\": 900, \"end\": 1700, \"available\": true}\n\t\t}")
#

# JSON format:
# {
# 	"Sunday": {"start": 0, "end": 0, "available": true},
# 	"Monday": {"start": 0, "end": 0, "available": true},
# 	"Tuesday": {"start": 0, "end": 0, "available": true},
# 	"Wednesday": {"start": 0, "end": 0, "available": true},
# 	"Thursday": {"start": 0, "end": 0, "available": true},
# 	"Friday": {"start": 0, "end": 0, "available": true},
# 	"Saturday": {"start": 0, "end": 0, "available": true}
# }


class Schedule < ActiveRecord::Base
	belongs_to :barber

	before_save :parse_json
	serialize :json

	def parse_json
		self.update_column('json', JSON.parse(self.json).to_json)
	end

	def get_json
		JSON.parse(self.json)
	end
end
