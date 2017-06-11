class SubscriptionsController < ApplicationController
	before_filter :set_plans, only: [:new, :create]

	def new
		if current_user and current_user.active?
			redirect_to root_path, success: "You already have an active subscription"
		end
	end

	def edit
	end

	def create
		begin
			customer = StripeSubscriptionService.create_customer(params)
			stripe_subscription = StripeSubscriptionService.create_subscription(customer, params)
			user_subscription = create_user_subscription(stripe_subscription)
			organization = create_organization(current_user, user_subscription, stripe_subscription)

			current_user.membership = Membership.create(organization: organization) if organization.present?

			if stripe_subscription.status === "active"
				flash[:success] = "Successfully signed up. Manage your barbershop here."
				respond_to do |format|
					format.js { render js: "window.location = '/dashboard';" }
				end
			else
				flash[:error] = "Something went wrong."
				respond_to do |format|
					format.js { render action: "new" }
				end
			end

		rescue Stripe::CardError => e
			flash[:error] = e.message
			respond_to do |format|
				format.js { render action: "new" }
			end
		end
	end

	def update
	end

	def destroy
		user = current_user
		if user.subscription.present? && user.active?
			subscription = user.subscription
			sub = Stripe::Subscription.retrieve(subscription.stripe_reference)
			sub.delete
			subscription.subscription_status = :canceled
			subscription.save
		end
		sign_out(user)
		redirect_to root_path, success: "Bye #{user.name}, we're sorry to see you go!"
	end

	def create_user_subscription(stripe_subscription)
		current_user.stripe_id = stripe_subscription.customer
		current_user.save

		subscription = Subscription.new(
			stripe_reference: stripe_subscription.id,
			customer_reference: stripe_subscription.customer,
			plan: stripe_subscription.plan.id,
			user: current_user
		)
		subscription.save
		subscription.subscription_status= stripe_subscription.status
		subscription
	end

	def create_organization(current_user, user_subscription, stripe_subscription)
		organization = Organization.create(
			user: current_user, stripe_reference: stripe_subscription.id, subscription_id: user_subscription.id
		)
	end

	private

	def subscription_params(params)
		params.permit(:stripeToken, :stripeEmail, :stripe_price, :description)
	end


	def set_plans
		@plans = [{
				name: "barber shop",
				price: 99.99,
				stripe_price: 9999,
				features: [
					"Unlimited barbers",
				]
			}
		]
	end

end
