class HomeController < ApplicationController
	include ApplicationHelper

	def index
	end

	def faq
	end

	def about
	end

	def search
		@barbers = get_react_barber_objects(Barber.all)
		@featured_barber = @barbers.sample
		@profile_id = current_user.profile.id
		@style = current_user.style.name
		@location = current_user.location
		@price = [1,2,3,4].sample
	end

	end
