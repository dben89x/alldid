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
		rates = []
		100.times {rates << rand(20..50)}
		quadrant_values = calculate_price_comparisons(rates)

		10.times do
			barber_styles = []
			rand(1..3).times { barber_styles << styles.sample }
			barber_services = []
			rand(1..3).times { barber_services << services.sample }

			rate = rates.sample
			price = find_price_quadrant(quadrant_values, rate)
			@barbers << {
				name: Faker::GameOfThrones.character,
				headline: Faker::Lorem.sentence,
				bio: Faker::Lorem.paragraph,
				location: Faker::GameOfThrones.city,
				price: price,
				styles: barber_styles,
				services: barber_services
			}
		end
		@featured_barber = @barbers.sample
	end

	# Returns an array of quadrant price values
	def calculate_price_comparisons(all_rates)
		# all_rates = User.includes(:profile).where.not(hourly_rate: nil).pluck(:hourly_rate)
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
