# == Schema Information
#
# Table name: hair_properties
#
#  id          :integer          not null, primary key
#  type        :string
#  name        :string
#  description :text
#

class HairProperty < ActiveRecord::Base
	has_many :client_hair_properties, inverse_of: :hair_property
end
