class HomeController < ApplicationController
	include ApplicationHelper

	def calendar
		@barber = Barber.find(params[:barber])
		@client = current_user
		@services = @barber.services
		@styles = @barber.styles
	end

	def index
	end

	def faq
	end

	def about
	end

	def search
		if current_user
			@barbers = get_react_barber_objects(Barber.all)

			@barbers = filterBarbers(@barbers)

			@barbers.each do |barber|
				barber[:barberStyles] = barber[:barberStyles].slice(0,3)
			end

			@featured_barber = @barbers[0]
			@barbers = @barbers - [@featured_barber]
			@profile_id = current_user.profile
			@style = current_user.current_style_id.present? ? current_user.style.name : Style.all.sample.name
			@location = current_user.location.present? ? current_user.location : Faker::GameOfThrones.city
			@price = [1,2,3,4].sample
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
		current_style_name = current_user.profile.current_style_name
		results = []
		barbers.each do |b|
			elements = b[:barberStyles].select {|bs| bs[:name] == current_style_name }
			results << {barber: b, element: elements[0]} if elements.present?
		end

		results.sort_by {|r| r[:element][:endorsements]}.reverse
	end

end
