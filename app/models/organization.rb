# == Schema Information
#
# Table name: organizations
#
#  id       :integer          not null, primary key
#  location :string
#  zip      :integer
#

class Organization < ActiveRecord::Base
	has_many :barbers
end
