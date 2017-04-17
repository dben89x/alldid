class RegistrationsController < Devise::RegistrationsController
	protected
	def update_resource(resource, params)
		if resource_params[:avatar]
			@profile = true
			resource_updated = resource.update_without_password(resource_params)
		else
			resource_updated = resource.update_with_password(account_update_params)
		end
	end

	private

	def resource_params
		if @profile
			params.require(:user).permit(:first_name, :last_name, :avatar, :avatar_cache, :headline, :bio, :location, :zip)
		else
			super
		end
	end
end
