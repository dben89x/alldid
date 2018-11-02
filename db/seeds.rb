styles = [ "french crop",
  "pompadour",
  "quiff",
  "shaped afro",
  "shoulder length",
  "side parting",
  "slick back",
  "textured fringe" ]

services = [ "Buzz cut",
  "Straight razor shave",
  "Beard trim",
  "Shampoo",
  "Hair color",
  "Neck shave",
  "Kid’s Haircut",
  "Overall trim" ]

days = [ "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday" ]

hair_properties = [ {
    type: "HairType",
    name: "Straight",
    description: "Straight Hair"
  }, {
    type: "HairType",
    name: "Wavy",
    description: "Wavy Hair"
  }, {
    type: "HairType",
    name: "Curly",
    description: "Curly Hair"
  }, {
    type: "HairType",
    name: "Kinky",
    description: "Kinky Hair"
  }, {
    type: "HairWidth",
    name: "Coarse",
    description: "These strands have the widest and largest circumferences and this makes them the strongest of all hair textures.",
  }, {
    type: "HairWidth",
    name: "Medium",
    description: "This is the middle of the road for thickness of hair strands; neither too small nor too big.",
  }, {
    type: "HairWidth",
    name: "Fine",
    description: "The circumference is extremely small and narrow, making it delicate and easy to damage.",
  }, {
    type: "HairDensity",
    name: "Thin",
    description: "Can almost see your scalp through your hair.",
  }, {
    type: "HairDensity",
    name: "Average",
    description: "Average Density",
  }, {
    type: "HairDensity",
    name: "Thick",
    description: "Your hair probably grows quickly and you feel resistance when combing.",
} ]

# If you must delete in production, do it manually
if Rails.env.development? or Rails.env.staging?
  Style.delete_all
  Service.delete_all
  User.delete_all
  Day.delete_all
  HairProperty.delete_all
end

Admin.create(
  email: 'dan@alldid.com',
  password: 'alldid'
)

styles.each do |style_name|
  Style.create(name: style_name, url: "#{style_name.gsub(' ','-')}.png")
end

services.each do |service_name|
  Service.create(name: service_name)
end

days.each do |day|
  Day.create(name: day)
end

hair_properties.each do |prop|
  HairProperty.create(prop)
end

if Rails.env.development? or Rails.env.staging?
  5.times do
    Location.create(name: Faker::GameOfThrones.city)
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
      location: Location.all.sample,
      minutes: [20,30,40,50].sample,
      rate: rand(10..100)
    )
    profile.save
    barber.profile_id = profile.id

    Style.all.sample(rand(3..4)).each do |style|
      profile.user_styles.new(style: style).save
    end
    Service.all.sample(rand(3..4)).each do |service|
      profile.user_services.new(service: service).save
    end

    client = Client.create(
      email: Faker::Internet.email,
      password: 'asdfasdf'
    )
    profile = client.profile = Profile.new(
      first_name: Faker::GameOfThrones.character,
      headline: Faker::Lorem.sentence,
      bio: Faker::Lorem.paragraph,
      location: Location.all.sample,
    )
  end

  Barber.all.each do |b|
    [1,2,3,4,5].sample.times do
      bs = b.barber_styles.create(style: Style.all.sample)
      [1,2,3,4,5].sample.times do
        bs.endorsements.create(client_id: Client.all.sample)
      end
    end
  end

  30.times do
    time = Time.at(rand * Time.now.to_i)
    Event.create(
      client: Client.all.sample,
      barber: Barber.all.sample,
      start_time: time,
      end_time: (time+([20,30,40].sample * 60)),
      style: Style.all.sample
    )
  end
end
