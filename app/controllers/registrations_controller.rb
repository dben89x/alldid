class RegistrationsController < Devise::RegistrationsController
	def new
		@organization = find_organization(cookies)
		super
	end

	def create
		super
		puts resource.type
		if resource.type == "Barber"
			organization = find_organization(cookies)
			if organization.present?
				resource.membership = Membership.create(organization: organization)
			else
				resource.type = "AdminBarber"
			end
		end
		resource.save
	end

	def find_organization(cookies)
		cookies[:invite].present? ? Organization.find_by(code: cookies[:invite]) : nil
	end

	def after_sign_up_path_for(resource)
		if organization = find_organization(cookies)
			flash[:success] = "You've successfully joined #{organization.name}! Customize your profile for your clients."
			profile_path
		elsif resource.type == "Barber" or resource.type == "AdminBarber"
			flash[:success] = "Successfully signed up! Customize your profile for your clients."
			profile_path
		elsif resource.type == "Client"
			flash[:success] = "Successfully signed up! Customize your profile for optimal results."
			profile_path
		else
			new_subscription_path
		end
	end

end
