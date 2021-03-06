class ProfilesController < ApplicationController
	before_action :set_variables, only: [:edit, :update]
	before_action :get_hair_properties, only: [:show, :edit]
	skip_before_action :verify_authenticity_token
	before_filter :ensure_active, only: [:edit]
	before_filter :ensure_complete, only: [:edit]

	def show
		@profile = Profile.find(params[:id])
		@user = @profile.user
		@user_type = @user.try(:type)
		if @user.is_a? Client
			get_client_hair_properties


			@hair_type ||= "#{@user.name} has not chosen a hair type yet."
			@hair_width ||= "#{@user.name} has not chosen a hair width yet."
			@hair_density ||= "#{@user.name} has not chosen a hair density yet."
		end
	end

	def edit
		@profile = current_user.profile
		@styles = Style.all
		@user_type = current_user.type
		@all_services = Service.all.pluck(:name)
		@locations = Location.all

		if current_user.is_a? Barber

			@barber_styles = current_user.barber_styles
			@barber_id = current_user.id

		elsif current_user.is_a? Client
			@client_style = @profile.current_style

			@current_type_id = current_user.hair_type.try(:id)
			@current_width_id = current_user.hair_width.try(:id)
			@current_density_id = current_user.hair_density.try(:id)
		end

		@user_services = current_user.services.pluck(:name)
	end

	def update
		@locations = Location.all
		respond_to do |format|
			if params[:profile][:services].present?
				@profile.user_services.delete_all

				params[:profile][:services].split(',').each do |service|
					service = Service.find_by(name: service)
					@profile.user_services.create(profile: @profile, service: service)
				end
			end

			if params[:profile][:styles].present?
				@profile.user_styles.delete_all

				params[:profile][:styles].split(',').each do |style|
					style = Style.find_by(name: style)
					@profile.user_styles.create(profile: @profile, style: style)
				end
			end

			if @profile.update(profile_params)
				flash[:success] = 'Profile was successfully updated.'
				format.html { redirect_to '/profile' }
				format.json { render json: @profile, status: :ok }

			else
				format.html { render :edit }
				format.json { render json: @profile.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def set_variables
		@profile = current_user.profile
		@locations = Location.all
		@ethnicities = Ethnicity.all
	end

	def get_hair_properties
		@hair_types = HairType.all
		@hair_widths = HairWidth.all
		@hair_densities = HairDensity.all
	end

	def get_client_hair_properties
		@hair_type = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_types).try(:name)
		@hair_width = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_widths).try(:name)
		@hair_density = ClientHairProperty.find_by(profile: @profile, hair_property: @hair_densities).try(:name)
	end


	def ensure_active
		if current_user.is_a? Barber
			unless current_user.active?
				flash.now[:alert] = "Your profile won't be visible until you <a href='/pricing'>create your barbershop.</a>".html_safe
			end
		end
	end

	def ensure_complete
		unless current_user.public?
			if current_user.is_a? Barber
				alert_message = "Please complete your profile to make it publicly visible."
			elsif current_user.is_a? Client
				alert_message = "Please complete your profile."
			end
			missing_fields = ''
			current_user.missing_fields.each {|field| missing_fields += "<br><b>#{field.to_s.gsub('_',' ').gsub(' id','').capitalize}</b>"}
			flash.now[:alert] = "#{alert_message}<br/>Missing fields: #{missing_fields}".html_safe
		end
	end

	def profile_params
		params.require(:profile).permit(
		:hair_type, :hair_width, :hair_density, :bio, :first_name, :last_name,
		:avatar, :headline, :location, :zip, :avatar_cache, :facebook, :instagram,
		:twitter, :current_style_id, :rate, :minutes, :location_id, :ethnicity_id
		)
	end
end
