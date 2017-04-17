class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :signed_in_root_path

	def signed_in_root_path(current_user)
		'/'
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
