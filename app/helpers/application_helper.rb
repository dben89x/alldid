module ApplicationHelper

	def bootstrap_class_for flash_type
		{ success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
	end

	def flash_messages(opts = {})
		flash.each do |msg_type, message|
			unless msg_type == 'success' || msg_type == 'notice'
				concat(content_tag(:div, message, class: "flash-messages alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
					concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
						concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
						concat content_tag(:span, 'Close', class: 'sr-only')
					end)
					concat message
				end)
			end
		end
		nil
	end

	def get_react_barber_objects(collection)
		rates = User.includes(:profile).where.not(profiles: {hourly_rate: nil}).pluck(:hourly_rate)
		quadrant_values = calculate_price_comparisons(rates)
		user = current_user

		collection.collect do |barber|
			favorite = user ? user.user_favorites.where(user_id: barber.id).present? : false
			{
				id: barber.id,
				name: barber.name,
				headline: barber.headline,
				bio: barber.bio,
				location: barber.location,
				price: find_price_quadrant(quadrant_values, barber.hourly_rate),
				styles: barber.styles.pluck(:name),
				services: barber.services.pluck(:name),
				favorite: favorite
			}
		end
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
