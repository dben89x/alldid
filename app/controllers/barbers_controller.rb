class BarbersController < ApplicationController
	include ApplicationHelper
	skip_before_filter :verify_authenticity_token, only: :create_schedule

	def show
		@barbers = get_react_barber_objects([User.find(params[:id])])
		@profile_id = current_user.profile.id
	end

	def calendar
		unless current_user.is_a? Barber or !current_user
			@barber = Barber.find(params[:barber])
			@minutes = @barber.minutes
			@rate = @barber.rate
			@schedule = @barber.schedules.last.try(:get_json)
			@unavailable_days = get_unavailable_days(@schedule)
			@client = current_user
			@services = Service.all
			@styles = @barber.styles
		else
			flash[:alert] = "You must be a client to use the calendar."
			redirect_to new_user_session_path
		end
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

	def get_unavailable_days(schedule)
		if schedule.present?
			count = 0
			days = []
			schedule.each do |key, value|
				unless value['available']
					days << count
				end
				count += 1
			end
			days
		else
			[]
		end
	end
end
