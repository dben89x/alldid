$(document).ready ->
	organizationLinkClip = new Clipboard('#organization-link-button')

	setTooltip = (btn, message) ->
		$(btn).tooltip('hide').attr('data-original-title', message).tooltip 'show'
		return

	hideTooltip = (btn) ->
		setTimeout (->
			$(btn).tooltip 'hide'
			return
		), 1000
		return

	$('#organization-link-button').tooltip
		trigger: 'click'
		placement: 'bottom'
	# Clipboard
	organizationLinkClip.on 'success', (e) ->
		setTooltip e.trigger, 'Copied!'
		hideTooltip e.trigger
		return
	organizationLinkClip.on 'error', (e) ->
		setTooltip e.trigger, 'Failed!'
		hideTooltip e.trigger
		return

	$('#organization-link-button').on('mouseenter', (->
		$(this).css 'background', 'rgba(26,177,136,0.2)'
	)).on('mouseleave', (->
		$(this).css 'background-color', 'rgba(26,177,136,0)'
	))
