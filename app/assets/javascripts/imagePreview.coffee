$(document).ready ->
	readURL = (input) ->
		if input.files and input.files[0]
			reader = new FileReader

			reader.onload = (e) ->
				$('#avatar-preview').css 'background-image', 'url(' + e.target.result + ')'
				return

			reader.readAsDataURL input.files[0]
		return

	$('#avatar-upload').change ->
		$('#avatar-preview').removeClass 'hidden'
		$('#empty-avatar-preview').addClass 'hidden'
		$('#current-avatar').addClass 'hidden'

		readURL this
		return
	return
