# == Schema Information
#
# Table name: barber_styles
#
#  id        :integer          not null, primary key
#  barber_id :integer
#  rate      :integer
#  minutes   :integer
#  style_id  :integer
#

class BarberStyle < ActiveRecord::Base
	belongs_to :barber, inverse_of: :barber_styles
	has_many :endorsements, inverse_of: :barber_style
	belongs_to :style
	delegate :name, to: :style
end
