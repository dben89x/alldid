class ProfilesController < ApplicationController
	before_action :set_profile, only: [:edit, :update]
	before_action :get_hair_properties, only: [:show, :edit]
	skip_before_action :verify_authenticity_token

	def show
		@profile = Profile.find(params[:id])
		@user = @profile.user
		@user_type = @user.try(:type)
		if @user.is_a? Client
			get_client_hair_properties

			# @hair_type = @hair_type ? @hair_type.name : "This user has not chosen a hair type yet."
			# @hair_width = @hair_width ? @hair_width.name : "This user has not chosen a hair width yet."
			# @hair_density = @hair_density ? @hair_density.name : "This user has not chosen a hair density yet."

			@hair_type ||= "#{@user.name} has not chosen a hair type yet."
			@hair_width ||= "#{@user.name} has not chosen a hair width yet."
			@hair_density ||= "#{@user.name} has not chosen a hair density yet."
		end
	end

	def edit
		@profile = current_user.profile
		@styles = Style.all
		@user_type = current_user.type
		@all_services = Service.all.pluck(:name)
		@locations = Location.all

		if current_user.is_a? Barber
			@barber_styles = current_user.barber_styles
			@barber_id = current_user.id

		elsif current_user.is_a? Client
			@client_style = @profile.current_style

			@current_type_id = current_user.hair_type.try(:id)
			@current_width_id = current_user.hair_width.try(:id)
			@current_density_id = current_user.hair_density.try(:id)
		end

		@user_services = current_user.services.pluck(:name)
	end

	def update
		@locations = Location.all
		respond_to do |format|
			if params[:profile][:services].present?
				@profile.user_services.delete_all

				params[:profile][:services].split(',').each do |service|
					service = Service.find_by(name: service)
					@profile.user_services.create(profile: @profile, service: service)
				end
			end

			if params[:profile][:styles].present?
				@profile.user_styles.delete_all

				params[:profile][:styles].split(',').each do |style|
					style = Style.find_by(name: style)
					@profile.user_styles.create(profile: @profile, style: style)
				end
			end

			if @profile.update(profile_params)
				format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
				format.json { render json: @profile, status: :ok }

			else
				format.html { render :edit }
				format.json { render json: @profile.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def set_profile
		@profile = current_user.profile
	end

	def get_hair_properties
		@hair_types = HairType.all
		@hair_widths = HairWidth.all
		@hair_densities = HairDensity.all
	end

	def get_client_hair_properties
		@hair_type = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_types).try(:name)
		@hair_width = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_widths).try(:name)
		@hair_density = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_densities).try(:name)
	end

	def profile_params
		params.require(:profile).permit(
		:hair_type, :hair_width, :hair_density, :bio, :first_name, :last_name,
		:avatar, :headline, :location, :zip, :avatar_cache, :facebook, :instagram,
		:twitter, :current_style_id, :rate, :minutes
		)
	end
end
