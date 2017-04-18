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
		10.times do
			@barbers << {
				name: Faker::GameOfThrones.character,
				headline: Faker::Lorem.sentence,
				bio: Faker::Lorem.paragraph,
				location: Faker::GameOfThrones.city,
				price: [1,2,3].sample,
			}
		end
		@featured_barber = {
			name: Faker::GameOfThrones.character,
			headline: Faker::Lorem.sentence,
			bio: Faker::Lorem.paragraph,
			location: Faker::GameOfThrones.city,
			price: [1,2,3].sample,
		}
	end
end
