# == Schema Information
#
# Table name: endorsements
#
#  id        :integer          not null, primary key
#  barber_id :integer
#  client_id :integer
#  style_id  :integer
#

class Endorsement < ActiveRecord::Base
	belongs_to :barber
	belongs_to :client
	belongs_to :style
end
