class HomeController < ApplicationController
	include ApplicationHelper

	def index
	end

	def faq
	end

	def about
	end

	def search
		current_user = current_user ? current_user : User.all.sample
		@barbers = get_react_barber_objects(Barber.all)
		@featured_barber = @barbers.sample
		@profile_id = current_user.profile
		@style = current_user.current_style_id.present? ? current_user.style.name : Style.all.sample.name
		@location = current_user.location
		@price = [1,2,3,4].sample
	end

end
