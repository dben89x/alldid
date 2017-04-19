class HomeController < ApplicationController
	def index
	end

	def faq
	end

	def about
	end

	def search
		styles = [ "buzz cut",
			"french crop",
			"pompadour",
			"quiff",
			"shaped afro/modern hightop fade",
			"shoulder length",
			"side parting",
			"slick back",
			"textured cut with fringe"
		]
		services = [ "Classic haircut",
			"Buzz cut",
			"Straight razor shave",
			"Beard trim",
			"Shampoo",
			"Hair color",
			"Neck shave",
			"Kid’s Haircut (12 and younger)",
			"Overall trim"
		]
		@barbers = []
		rates = User.includes(:profile).where.not(profiles: {hourly_rate: nil}).pluck(:hourly_rate)
		quadrant_values = calculate_price_comparisons(rates)

		@barbers =  Barber.all.collect do |barber|
			{
				id: barber.id,
				name: barber.name,
				headline: barber.headline,
				bio: barber.bio,
				location: barber.location,
				price: find_price_quadrant(quadrant_values, barber.hourly_rate),
				styles: barber.styles.pluck(:name),
				services: barber.services.pluck(:name)
			}
		end
		@featured_barber = @barbers.sample
	end

	# Returns an array of quadrant price values
	def calculate_price_comparisons(all_rates)
		sorted_rates = all_rates.sort
		rates_count = all_rates.count

		quadrant_values = []
		quadrant = 1
		4.times do
			quadrant_size = (rates_count - 1) / 4
			upper_quadrant_bound_index = quadrant_size * quadrant
			upper_quadrant_bound_value = sorted_rates[ upper_quadrant_bound_index ]
			quadrant_values << upper_quadrant_bound_value
			quadrant += 1
		end
		quadrant_values[3] = sorted_rates.max
		quadrant_values
	end

	def find_price_quadrant(quadrant_values, rate)
		quadrant_values.each_with_index do |value, index|
			if rate <= value
				return index + 1
			end
		end
	end
end
