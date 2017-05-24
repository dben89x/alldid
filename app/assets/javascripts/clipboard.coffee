$(document).ready ->
	organizationLinkClip = new ZeroClipboard($('#organization-link-button'))

	$('#organization-link-button').hover (->
		$(this).css 'background', 'rgba(26,177,136,0.2)'
	), ->
		$(this).css 'background-color', 'rgba(26,177,136,0)'
