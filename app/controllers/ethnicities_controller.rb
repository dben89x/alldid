class EthnicitiesController < ApplicationController
	before_action :set_ethnicity, only: [:show, :edit, :update, :destroy]
	authorize_resource

	def new
		@ethnicity = Ethnicity.new
	end

	def edit
	end

	def index
		@ethnicities = Ethnicity.all
	end

	def create
		@ethnicity = Ethnicity.new(ethnicity_params)

		respond_to do |format|
			if @ethnicity.save
				flash[:success] = 'Ethnicity was successfully created.'
				format.html { redirect_to ethnicities_path }
				format.json { render :show, status: :created, location: @ethnicity }
			else
				format.html { render :new }
				format.json { render json: @ethnicity.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @ethnicity.update(ethnicity_params)
				flash[:success] = 'Ethnicity was successfully updated.'
				format.html { redirect_to ethnicities_path }
				format.json { render :show, status: :ok, location: @ethnicity }
			else
				format.html { render :edit }
				format.json { render json: @ethnicity.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
			@ethnicity.destroy
		respond_to do |format|
			flash[:success] = 'Ethnicity was successfully destroyed.'
			format.html { redirect_to ethnicities_path }
			format.json { head :no_content }
		end
	end

	private
	def set_ethnicity
		@ethnicity = Ethnicity.find(params[:id])
	end

	def ethnicity_params
		params.require(:ethnicity).permit(:name)
	end

end
