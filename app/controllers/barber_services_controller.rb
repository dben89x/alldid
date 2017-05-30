class BarberServicesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@user = User.find(params[:user_id])

		old_services = @user.services
		new_services = params[:services].to_hash.map{|k,v| Service.find_by(name: v['value'])}

		services_to_be_deleted.each do |deleted_service|
			@user.user_services.find_by(service_id: deleted_service.id).destroy
		end

		services_to_be_added.each do |added_service|
			@user.user_services.create(service_id: added_service.id)
		end
		render json: @user.services, status: 200
	end

	def barber_services_params
		params.permit(:user_id, :services)
	end

	def delete_barber_service

	end
end
