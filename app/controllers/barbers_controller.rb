class BarbersController < ApplicationController
	include ApplicationHelper
	skip_before_filter :verify_authenticity_token, only: :create_schedule

	def show
		@barbers = get_react_barber_objects([Barber.find(params[:id])])
		@profile_id = current_user.profile.id
	end

	def schedule
		@events = Event.where(barber: current_user)
		@schedule = Schedule.find_by(barber: current_user)
		@days = Day.all
	end

	def create_schedule
		respond_to do |format|
			if true
				format.json { render json: {}, status: 200 }
			else
				format.json { render json: {}, status: :unprocessable_entity }
			end
		end
	end
end
