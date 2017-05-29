$.rails.allowAction = (element) ->
	# The message is something like "Are you sure?"
	message = element.data('confirm')
	notice = ""
	cancel_message = ""
	# If there's no message, there's no data-confirm attribute,
	# which means there's nothing to confirm
	return true unless message
	# Clone the clicked element (probably a delete link) so we can use it in the dialog box.
	$link = element.clone()
		# We don't necessarily want the same styling as the original link/button.
		.removeAttr('class')
		# We don't want to pop up another confirmation (recursion)
		.removeAttr('data-confirm')
		# We want a button
		.addClass('btn').addClass('btn-danger')
		.text('Delete')

	# messages
	if element.hasClass('delete-style')
		notice = """
							<p>
								Are you sure you want to delete this style?
							</p>
							"""
		cancel_message = "No, stop!"

	if element.hasClass('delete-service')
		notice = """
							<p>
								Are you sure you want to delete this service?
							</p>
							"""
		cancel_message = "No, stop!"

	if element.hasClass('delete-membership')
		notice = """
							<p>
								Are you sure you want to delete this member?
							</p>
							"""
		cancel_message = "No, stop!"

	if element.hasClass('cancel-account')
		notice = """
							<p>
								Are you sure you want to cancel?
							</p>
							<p>
								If you have a group membership, this will cancel all members.
							</p>
							"""
		cancel_message = "No, stop!"

	if element.hasClass('delete-hair_property')
		notice = """
							<p>
								Are you sure you want to delete this hair property?
							</p>
							"""
		cancel_message = "No, stop!"

	modal_html = """
								<div class="modal" id="myModal" style="color:white;text-align:center;">
									<div class="modal-header">
										<a class="close" data-dismiss="modal">×</a>
										<br><br><br><br><br><br>
										<h3>#{message}</h3>
									 </div>
									 <div class="modal-body">
										#{notice}
									 </div>
									<div class="modal-footer" style="text-align:center">
										<a data-dismiss="modal" class="btn btn-warning" style="margin:20px">#{cancel_message}</a>
									</div>
								</div>
								"""
	$modal_html = $(modal_html)
	# Add the new button to the modal box
	$modal_html.find('.modal-footer').append($link)
	# Pop it up
	$modal_html.modal()
	# Prevent the original link from working
	return false
