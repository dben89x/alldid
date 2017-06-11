# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  stripe_reference       :string
#  subscription_status_id :integer
#  customer_reference     :string
#  user_id_id             :integer
#  plan                   :string
#

class Subscription < ActiveRecord::Base

	SUBSCRIPTION_STATUSES = [:trialing, :trial_ended, :assessing, :active,
													 :soft_failure, :past_due, :suspended, :canceled,
													 :unpaid, :expired]

	has_one :organization
	has_one :user

	def subscription_status
		SUBSCRIPTION_STATUSES[subscription_status_id] if subscription_status_id
	end

	def subscription_status=(new_status)
		new_status = new_status.to_sym
		self.update_column('subscription_status_id', SUBSCRIPTION_STATUSES.index(new_status))
	end

	def active?
		subscription_status == :active
	end

end
