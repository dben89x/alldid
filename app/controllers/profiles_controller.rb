class ProfilesController < ApplicationController
	before_action :set_profile, only: [:show, :edit, :update]
	load_and_authorize_resource

	def show
	end

	def edit
		if current_user.is_a? Barber
			@styles = Style.all
			@services = Service.all
		end
	end

	def update
		respond_to do |format|
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
		@profile = Profile.find_by(user_id: current_user.id)
	end

	def profile_params
		params.require(:profile).permit(
			:hair_type, :hair_width, :hair_density, :bio, :hourly_rate, :first_name,
			:last_name, :avatar, :headline, :location, :zip
		)

	end
end
