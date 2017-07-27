class ServicesController < ApplicationController
	before_action :set_service, only: [:show, :edit, :update, :destroy]
	authorize_resource

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
				flash[:success] = 'Service was successfully created.'
				format.html { redirect_to services_path }
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
				flash[:success] = 'Service was successfully updated.'
				format.html { redirect_to services_path }
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
			flash[:success] = 'Service was successfully destroyed.'
			format.html { redirect_to services_path }
			format.json { head :no_content }
		end
	end

	private
	def set_service
		@service = Service.find(params[:id])
	end

	def service_params
		params.require(:service).permit(:name,:description)
	end
end
