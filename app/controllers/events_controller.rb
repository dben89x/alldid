class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

	def new
		@event = Event.new
	end

	def edit
	end

	def index
		@events = Event.where(barber_id: params['barberId'], date: params['date'].to_date)
		respond_to do |format|
			format.json {render json: @events}
		end
	end

	def create
		@event = Event.new(event_params)

		respond_to do |format|
			if @event.save
				format.html { redirect_to @event, notice: 'Event was successfully created.' }
				format.json { render json: @event, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @event.update(event_params)
				format.html { redirect_to @event, notice: 'Event was successfully updated.' }
				format.json { render json: @event, status: :ok}
			else
				format.html { render :edit }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@event.destroy
		respond_to do |format|
			format.html { redirect_to events_path, notice: 'Event was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:client_id, :barber_id, :style_id, :start_time, :end_time, :notes, :services)
	end
end
