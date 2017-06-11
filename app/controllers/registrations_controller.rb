class RegistrationsController < Devise::RegistrationsController
	def new
		@organization = find_organization(cookies)
		super
	end

	def create
		super
		if resource.type == "Barber"
			organization = find_organization(cookies)
			if organization.present?
				puts "Not Things"
				resource.membership = Membership.create(organization: organization)
			else
				puts "Things"
				resource.barbershop_owner = true
				puts resource.inspect
			end
		end
		resource.save
		puts resource.inspect
	end

	def find_organization(cookies)
		cookies[:invite].present? ? Organization.find_by(code: cookies[:invite]) : nil
	end

	def after_sign_up_path_for(resource)
		if organization = find_organization(cookies)
			flash[:success] = "You've successfully joined #{organization.name}! Customize your profile for your clients."
			"/profile"
		elsif resource.type == "Barber"
			flash[:success] = "Please enter your payment details to create your barber shop."
			"/pricing"
		elsif resource.type == "Client"
			flash[:success] = "Successfully signed up! Customize your profile for optimal results."
			"/profile"
		else
			new_subscription_path
		end
	end

end
