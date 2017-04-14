module StripeSubscriptionService

	def self.create_customer(params)
		Stripe::Customer.create(
			customer_params(params[:stripeEmail], params[:stripeToken])
		)
	end

	def self.create_charge(customer, params)
		Stripe::Charge.create(
			charge_params(customer.id, params[:stripe_price], params[:description])
		)
	end

	def self.customer_params(email, token)
		{
			email: email,
			source: token
		}
	end

	def self.charge_params(customer_id, amount, description)
		{
			customer: customer_id,
			amount: amount,
			description: description,
			currency: 'usd'
		}
	end

	def card_params(number,month,year,cvc)
		{
			number: number,
			exp_month: exp_month,
			exp_year: exp_year,
			cvc: cvc
		}
	end
end
