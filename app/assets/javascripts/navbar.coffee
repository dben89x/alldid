$(document).ready ->
	checkScroll = ->
		startY = $('.navbar-transparent').height() * 2
		#The point where the navbar changes in px
		if $(window).scrollTop() > startY
			$('.navbar-transparent').addClass 'scrolled'
		else
			$('.navbar-transparent').removeClass 'scrolled'
		return

	if $('.navbar-transparent').length > 0
		$(window).on 'scroll load resize', ->
			checkScroll()
			return
