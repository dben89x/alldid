# == Schema Information
#
# Table name: client_hair_properties
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  hair_property_id :integer
#

class ClientHairProperty < ActiveRecord::Base
	belongs_to :profile, inverse_of: :client_hair_properties
	belongs_to :hair_property, inverse_of: :client_hair_properties

	delegate :name, to: :hair_property
end
