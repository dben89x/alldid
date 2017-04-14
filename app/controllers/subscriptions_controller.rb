class SubscriptionsController < ApplicationController
	before_filter :set_plans, only: :new

	def new
	end

	def edit
		@current_plan = @plans.select{|plan| plan.id==current_pharmacy.payment_plan_id}.first
	end

	def create
		puts "Your params: #{params.inspect}"
		customer = StripeSubscriptionService.create_customer(params)
		charge = StripeSubscriptionService.create_charge(customer, params)

		if charge.status === "succeeded"
			redirect_to pricing_path, notice: "Successfully did your shit!"
		else
			render :new
		end

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_subscription_path
	end

	private

	def set_plans
		@plans = [{
				name: "individual",
				price: 4.99,
				stripe_price: 499,
				features: [
					"Unlimited saves"
				]
			}, {
				name: "group",
				price: 99.99,
				stripe_price: 9999,
				features: [
					"Unlimited saves",
					"50 members",
				]
			}, {
				name: "institution",
				price: 299.99,
				stripe_price: 29999,
				features: [
					"Unlimited saves",
					"Unlimited members"
				]
			}
		]
	end

end
