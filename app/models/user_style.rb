# == Schema Information
#
# Table name: user_styles
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  style_id   :integer
#

class UserStyle < ActiveRecord::Base
	belongs_to :profile, inverse_of: :user_styles
	belongs_to :style
end
