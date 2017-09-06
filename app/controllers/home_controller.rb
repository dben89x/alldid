class HomeController < ApplicationController
	include ApplicationHelper

	def index
	end

	def faq
	end

	def about
	end

	def appointments
		@events = Event.where(client_id: current_user.id)
	end

	def search
		@signedIn = current_user ? true : false

		if current_user
			@user_avatar = @signedIn ? current_user.default_avatar : '/assets/default-avatar.png'

			# Temporarily removing public check
			# @barbers = get_react_barber_objects(Barber.all.select{|b| b.public?})
			@barbers = get_react_barber_objects(Barber.all)

			if current_user
				@barbers = filterBarbers(@barbers)
			else
				@barbers = @barbers.shuffle
			end

			@barbers.each do |barber|
				barber[:barberStyles] = barber[:barberStyles].slice(0,3)
			end

			@featured_barber = @barbers[0]
			@barbers = @barbers - [@featured_barber]
			@profile_id = current_user.profile.id
			@style = current_user.current_style_id.present? ? current_user.style.name : "Choose your Style"
			@location = current_user.location.present? ? current_user.location : "Choose your Location"
			# @price = [1,2,3,4].sample
		else
			redirect_to new_user_registration_path, alert: "Please create your account to access this page."
		end

	end

	def filterBarbers(barbers)
		newBarbers = []

		results = get_top_barbers_by_style(barbers)
		top_style_barbers = results.pluck(:barber)

		top_style_barbers.each do |tsb|
			newBarbers << tsb
		end
		barbers = barbers - top_style_barbers

		barbers = barbers.sort_by {|b| b[:price]}
		barbers.each do |b|
			newBarbers << b
		end

		newBarbers
	end

	def get_top_barbers_by_style(barbers)
		puts "Barbers: #{barbers}"
		current_style_name = current_user.profile.current_style_name
		results = []
		barbers.each do |b|
			matching_styles = b[:barberStyles].select {|bs| bs[:name] == current_style_name }
			results << {barber: b, matching_style: matching_styles[0]} if matching_styles.present?
		end

		results.sort_by {|r| r[:matching_style][:endorsements]}.reverse
	end

end
