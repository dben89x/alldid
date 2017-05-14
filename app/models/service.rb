# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  minutes     :integer
#

class Service < ActiveRecord::Base
end
