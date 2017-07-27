class LocationsController < ApplicationController
	before_action :set_location, only: [:show, :edit, :update, :destroy]
	authorize_resource

	def new
		@location = Location.new
	end

	def edit

	end

	def index
		@locations = Location.all
	end

	def create
		@location = Location.new(location_params)

		respond_to do |format|
			if @location.save
				flash[:success] = 'Location was successfully created.'
				format.html { redirect_to locations_path }
				format.json { render :show, status: :created, location: @location }
			else
				format.html { render :new }
				format.json { render json: @location.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @location.update(location_params)
				flash[:success] = 'Location was successfully updated.'
				format.html { redirect_to locations_path }
				format.json { render :show, status: :ok, location: @location }
			else
				format.html { render :edit }
				format.json { render json: @location.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
			@location.destroy
		respond_to do |format|
			flash[:success] = 'Location was successfully destroyed.'
			format.html { redirect_to locations_path }
			format.json { head :no_content }
		end
	end

	private
	def set_location
		@location = Location.find(params[:id])
	end

	def location_params
		params.require(:location).permit(:name)
	end

end
