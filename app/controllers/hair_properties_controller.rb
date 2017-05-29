class HairPropertiesController < ApplicationController
	before_action :set_hair_property, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def new
		@hair_property = HairProperty.new
		@types = ["HairStyle", "HairWidth", "HairDensity"]
	end

	def edit

	end

	def index
		@hair_types = HairType.all
		@hair_widths = HairWidth.all
		@hair_densities = HairDensity.all
	end

	def create
		@hair_property = HairProperty.new(hair_property_params)

		respond_to do |format|
			if @hair_property.save
				format.html { redirect_to @hair_property, notice: 'Hair Property was successfully created.' }
				format.json { render :show, status: :created, location: @hair_property }
			else
				format.html { render :new }
				format.json { render json: @hair_property.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @hair_property.update(hair_property_params)
				format.html { redirect_to @hair_property, notice: 'Hair Property was successfully updated.' }
				format.json { render :show, status: :ok, location: @hair_property }
			else
				format.html { render :edit }
				format.json { render json: @hair_property.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@hair_property.destroy
		respond_to do |format|
			format.html { redirect_to hair_properties_path, notice: 'Hair Property was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_hair_property
		@hair_property = HairProperty.find(params[:id])
		@types = ["HairStyle", "HairWidth", "HairDensity"]
	end

	def hair_property_params
		params.require(:hair_property).permit(:name,:description,:type)
	end
end
