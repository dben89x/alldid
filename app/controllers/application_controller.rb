class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_filter :get_user_profile

	def get_user_profile
		authenticate_user!
		if current_user.is_a? Barber
			@user_profile = current_user.barber_profile
		elsif current_user.is_a? Client
			@user_profile = current_user.client_profile
		end
	end
end
