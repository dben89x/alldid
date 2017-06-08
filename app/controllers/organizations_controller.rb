class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:edit, :update]
	skip_before_action :verify_authenticity_token

	def edit
	end

	def update
		respond_to do |format|
			if @organization.update(organization_params)
				format.html { redirect_to '/dashboard', notice: 'Organization was successfully updated.' }
				format.json { render json: @organization }
			else
				format.html { render '/dashboard' }
				format.json { render json: @organization.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	def set_organization
		@organization = Organization.find_by(user: current_user)
	end

	def organization_params
		params.require(:organization).permit(:name)
	end

end
