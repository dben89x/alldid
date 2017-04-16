class ProfilesController < ApplicationController

	before_action :set_profile, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource

	def show
	end

	def edit
	end

	def update
		respond_to do |format|
			if @profile.update(profile_params)
				format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
				format.json { render :show, status: :ok, location: @profile }
			else
				format.html { render :edit }
				format.json { render json: @profile.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	def set_profile
		@profile = current_user.is_a? Barber ? BarberProfile.find(params[:id]) : ClientProfile.find(params[:id])
	end

	def profile_params
		params.require(:profile).permit(:avatar)
	end
end
