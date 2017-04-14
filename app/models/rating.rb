# == Schema Information
#
# Table name: ratings
#
#  id        :integer          not null, primary key
#  barber_id :integer
#  client_id :integer
#  text      :text
#  rating    :integer
#

class Rating < ActiveRecord::Base
	belongs_to :barber
	belongs_to :client
end
