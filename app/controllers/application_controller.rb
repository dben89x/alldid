class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :check_for_invite
	before_filter :display_staging_alert

	def check_for_invite
		if params[:invite].present?
			cookies[:invite] = params[:invite]
		end
	end

	def display_staging_alert
		if Rails.env.staging?
			unless current_user
				flash[:success] = "This is the staging site for <a href='https://alldid.com' target='blank'>alldid.com</a>. Log in <a href='/users/sign_in'>here</a> as <b>client@test.com</b> for full site features. Password is <b>password</b>.".html_safe
			end
		end
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :type) }
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password) }
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
