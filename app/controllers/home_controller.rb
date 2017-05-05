class HomeController < ApplicationController
	include ApplicationHelper

	def calendar

	end
	
	def index
	end

	def faq
	end

	def about
	end

	def search
		@barbers = get_react_barber_objects(Barber.all)
		if current_user
			@featured_barber = @barbers.sample
			@profile_id = current_user.profile
			@style = current_user.current_style_id.present? ? current_user.style.name : Style.all.sample.name
			@location = current_user.location.present? ? current_user.location : Faker::GameOfThrones.city
			@price = [1,2,3,4].sample
		end
	end

end
