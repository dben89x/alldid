class ServicesController < ApplicationController
	before_action :set_service, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def new
		@service = Service.new
	end

	def edit

	end

	def index

	end

	def create
		@service = Service.new(service_params)

		respond_to do |format|
			if @service.save
				format.html { redirect_to @service, notice: 'Service was successfully created.' }
				format.json { render :show, status: :created, location: @service }
			else
				format.html { render :new }
				format.json { render json: @service.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @service.update(service_params)
				format.html { redirect_to @service, notice: 'Service was successfully updated.' }
				format.json { render :show, status: :ok, location: @service }
			else
				format.html { render :edit }
				format.json { render json: @service.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@service.destroy
		respond_to do |format|
			format.html { redirect_to services_path, notice: 'Service was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_service
		@service = Service.find_by_slug(params[:id])
	end

	def service_params
		params.require(:service).permit(:name,:description)
	end
end
