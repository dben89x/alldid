# == Schema Information
#
# Table name: client_profiles
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  hair_type         :integer
#  hair_width        :integer
#  hair_density      :integer
#  perfect_barber_id :integer
#

class ClientProfile < ActiveRecord::Base
	belongs_to :client
end
