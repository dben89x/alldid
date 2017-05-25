# == Schema Information
#
# Table name: unavailable_days
#
#  id          :integer          not null, primary key
#  description :string
#  date        :datetime
#  barber_id   :integer
#

class UnavailableDay < ActiveRecord::Base

end
