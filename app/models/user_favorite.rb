# == Schema Information
#
# Table name: user_favorites
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  user_id    :integer
#

class UserFavorite < ActiveRecord::Base
	belongs_to :profile
	belongs_to :user
end
