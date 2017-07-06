# == Schema Information
#
# Table name: styles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  url         :string
#

class Style < ActiveRecord::Base
	mount_uploader :url, StyleUploader
	
	has_many :events, inverse_of: :style

end
