# == Schema Information
#
# Table name: endorsements
#
#  id              :integer          not null, primary key
#  client_id       :integer
#  barber_style_id :integer
#

class Endorsement < ActiveRecord::Base
	belongs_to :barber_style, inverse_of: :endorsements
	belongs_to :client
	delegate :style, to: :barber_style
end
