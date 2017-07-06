$(document).ready ->
	$('.view-schedule').on 'click', ->
		spanElement = $($(this).children()[0])
		if spanElement.hasClass('fa-chevron-down')
			spanElement.removeClass('fa-chevron-down').addClass('fa-chevron-up')
		else if spanElement.hasClass('fa-chevron-up')
			spanElement.removeClass('fa-chevron-up').addClass('fa-chevron-down')
