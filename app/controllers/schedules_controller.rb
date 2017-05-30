class SchedulesController < ApplicationController
	before_action :set_schedule, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource
	skip_before_action :verify_authenticity_token

	def new
		@schedule = Schedule.new
	end

	def edit

	end

	def index

	end

	def create
		@schedule = Schedule.new(schedule_params)

		respond_to do |format|
			if @schedule.save
				format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
				format.json { render :show, status: :created, location: @schedule }
			else
				format.html { render :new }
				format.json { render json: @schedule.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @schedule.update(schedule_params)
				format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
				format.json { render :show, status: :ok, location: @schedule }
			else
				format.html { render :edit }
				format.json { render json: @schedule.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@schedule.destroy
		respond_to do |format|
			format.html { redirect_to schedules_path, notice: 'Schedule was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_schedule
		@schedule = Schedule.find(params[:id])
	end

	def schedule_params
		params.require(:schedule).permit(:client_id, :barber_id, :service_id, :start_time, :end_time, :notes)
	end
end