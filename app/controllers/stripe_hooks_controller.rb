require 'stripe'
class StripeHooksController < ApplicationController
	protect_from_forgery except: :receive_webhooks
	# skip_before_filter  :verify_authenticity_token
	skip_before_action :authenticate_user!, raise: false

	ACCEPTED_EVENTS = %w[ customer_created
												customer_updated
												customer_subscription_created
												customer_subscription_updated
												customer_subscription_deleted
												customer_source_created
												customer_source_deleted
												charge_succeeded
												charge_failed
												invoice_created
												invoiceitem_created
												invoiceitem_deleted
												invoice_payment_succeeded
												invoice_payment_failed ]

	def receive_webhooks
		# @event = Stripe::Event.retrieve(params[:id])

		@event = JSON.parse(request.body.read)
		event_type = @event['type'].gsub('.','_')
		if ACCEPTED_EVENTS.include? event_type
			send event_type
		else
			head :not_found and return
		end
	end

	##############################
	# ACCOUNT
	##############################
	def account_updated
		head :ok
	end

	def account_external_account_created
		head :ok
	end

	def account_external_account_updated
		head :ok
	end

	def account_external_account_deleted
		head :ok
	end

	##############################
	# BALANCE
	##############################
	def balance_available
		head :ok
	end

	##############################
	# CHARGE
	##############################
	def charge_succeeded
		head :ok
	end

	def charge_updated
		head :ok
	end

	def charge_failed
		head :ok
	end

	def charge_refunded
		head :ok
	end

	def charge_captured
		head :ok
	end

	##############################
	# CHARGE DISPUTE
	##############################
	def charge_dispute_created
		head :ok
	end

	def charge_dispute_updated
		head :ok
	end

	def charge_dispute_closed
		head :ok
	end

	def charge_dispute_funds_withdrawn
		head :ok
	end

	def charge_dispute_funds_reinstated
		head :ok
	end

	##############################
	# COUPON
	##############################
	def coupon_created
		head :ok
	end

	def coupon_updated
		head :ok
	end

	def coupon_deleted
		head :ok
	end

	##############################
	# CUSTOMER
	##############################
	def customer_created
		head :ok
	end

	def customer_updated
		head :ok
	end

	def customer_deleted # this should never happen!!
	end

	##############################
	# CUSTOMER DISCOUNT
	##############################
	def customer_discount_created
		head :ok
	end

	def customer_discount_updated
		head :ok
	end

	def customer_discount_deleted
		head :ok
	end

	##############################
	# CUSTOMER SUBSCRIPTION
	##############################
	def customer_subscription_created
		head :ok
	end

	def customer_subscription_updated
		set_subscription(@event)
		new_status = @event['data']['object']['status']
		@subscription.subscription_status= new_status
		head :ok
	end

	def customer_subscription_deleted
		head :ok
	end

	def customer_subscription_trial_will_end
		head :ok
	end

	##############################
	# CUSTOMER SOURCE (PAYMENT INFO)
	##############################
	def customer_source_created
		head :ok
	end

	def customer_source_updated
		head :ok
	end

	def customer_source_deleted
		head :ok
	end

	##############################
	# INVOICE
	##############################
	def invoice_created
		head :ok
	end

	def invoice_updated
		head :ok
	end

	def invoice_payment_succeeded
		head :ok
	end

	def invoice_payment_failed
		head :ok
	end

	##############################
	# INVOICE ITEM
	##############################
	def invoiceitem_created
		head :ok
	end

	def invoiceitem_updated
		head :ok
	end

	def invoiceitem_deleted
		head :ok
	end

	##############################
	# PLAN
	##############################
	def plan_created
		head :ok
	end

	def plan_updated
		head :ok
	end

	def plan_deleted
		head :ok
	end

	##############################
	# RECIPIENT
	##############################
	def recipient_created
		head :ok
	end

	def recipient_updated
		head :ok
	end

	def recipient_deleted
		head :ok
	end

	##############################
	# TRANSFER
	##############################
	def transfer_created
		head :ok
	end

	def transfer_updated
		head :ok
	end

	def transfer_paid
		head :ok
	end

	def transfer_failed
		head :ok
	end

	def transfer_reversed
		head :ok
	end

	##############################
	# END OF EVENTS
	##############################

	def set_subscription(event)
		subscription_id = event['data']['object']['id']
		@subscription = Subscription.find_by(stripe_reference: subscription_id)
	end

end
