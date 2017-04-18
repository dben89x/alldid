class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
			user_params.permit(:email, :password, :type)
		end
	end
	
	# before_filter :get_user_profile

	# def get_user_profile
	# 	if current_user.acting_as Barber
	# 		@user_profile = current_user.barber_profile
	# 	elsif current_user.is_a? Client
	# 		@user_profile = current_user.client_profile
	# 	end
	# end
end
