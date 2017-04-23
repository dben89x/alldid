styles = [ "french crop",
	"pompadour",
	"quiff",
	"shaped afro",
	"shoulder length",
	"side parting",
	"slick back",
	"textured fringe" ]

services = [ "Classic haircut",
	"Buzz cut",
	"Straight razor shave",
	"Beard trim",
	"Shampoo",
	"Hair color",
	"Neck shave",
	"Kid’s Haircut",
	"Overall trim" ]

Style.delete_all
Service.delete_all
User.delete_all

styles.each do |style_name|
	Style.create(name: style_name)
end

services.each do |service_name|
	Service.create(name: service_name)
end

20.times do
	barber = Barber.create(
		email: Faker::Internet.email,
		password: 'asdfasdf'
	)
	profile = barber.profile = Profile.new(
		first_name: Faker::GameOfThrones.character,
		headline: Faker::Lorem.sentence,
		bio: Faker::Lorem.paragraph,
		location: Faker::GameOfThrones.city,
		hourly_rate: rand(30..60)
	)
	profile.save
	barber.profile_id = profile.id

	Style.all.sample(rand(3..4)).each do |style|
		profile.user_styles.new(style: style).save
	end
	Service.all.sample(rand(3..4)).each do |service|
		profile.user_services.new(service: service).save
	end
end
