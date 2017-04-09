$(document).ready ->
	$('.initial-fade-in-short').animate { 'opacity': '1' }, 700

	$('.initial-fade-in-long').animate { 'opacity': '1' }, 1400

	$(window).scroll ->

		### Check the location of each desired element ###

		$('.fade-in').each (i) ->
			bottom_of_object = $(this).offset().top + $(this).outerHeight()
			bottom_of_window = $(window).scrollTop() + $(window).height()

			### If the object is completely visible in the window, fade it it ###
			if bottom_of_window > bottom_of_object
				$(this).animate { 'opacity': '1' }, 500
