class ProfilesController < ApplicationController
	before_action :set_profile, only: [:show, :edit, :update]
	load_and_authorize_resource

	def show
	end

	def edit
		if current_user.is_a? Barber
			@all_styles = Style.all.pluck(:name)
			@all_services = Service.all.pluck(:name)
			@user_styles = current_user.styles.pluck(:name)
			@user_services = current_user.services.pluck(:name)
		end
	end

	def update
		respond_to do |format|
			@profile.user_styles.delete_all
			@profile.user_services.delete_all

			params[:profile][:services].split(',').each do |service|
				service = Service.find_by(name: service)
				@profile.user_services.create(profile: @profile, service: service)
			end
			params[:profile][:styles].split(',').each do |style|
				style = Style.find_by(name: style)
				@profile.user_styles.create(profile: @profile, style: style)
			end

			if @profile.update(profile_params)
				format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
				format.json { render :show, status: :ok, location: @profile }
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

	def profile_params
		params.require(:profile).permit(
			:hair_type, :hair_width, :hair_density, :bio, :hourly_rate, :first_name,
			:last_name, :avatar, :headline, :location, :zip, :avatar_cache, :facebook,
			:instagram, :twitter
		)
	end
end
