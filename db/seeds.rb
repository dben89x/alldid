styles = [ "buzz cut",
"french crop",
"pompadour",
"quiff",
"shaped afro/modern hightop fade",
"shoulder length",
"side parting",
"slick back",
"textured cut with fringe" ]

services = [ "Classic haircut",
	"Buzz cut",
	"Straight razor shave",
	"Beard trim",
	"Shampoo",
	"Hair color",
	"Neck shave",
	"Kid’s Haircut (12 and younger)",
	"Overall trim" ]

styles.each do |style_name|
	Style.create(name: style_name)
end

services.each do |service_name|
	Service.create(name: service_name)
end
