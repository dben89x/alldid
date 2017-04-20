class BarbersController < ApplicationController
	include ApplicationHelper
	def show
		@barbers = get_react_barber_objects([Barber.find(params[:id])])
		@profile_id = current_user.profile.id
	end
end
