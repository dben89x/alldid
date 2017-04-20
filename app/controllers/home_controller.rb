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
	end

	end
