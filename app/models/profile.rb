# == Schema Information
#
# Table name: profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  hair_type         :integer
#  hair_width        :integer
#  hair_density      :integer
#  perfect_barber_id :integer
#  current_style_id  :integer
#  bio               :text
#  hourly_rate       :integer
#  organization_id   :integer
#

class Profile < ActiveRecord::Base
	belongs_to :user
end
