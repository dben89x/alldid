class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new

		can :manage, Profile, user_id: user.id
		can :read, :all

		if user.is_a? Admin
			can :manage, :all
		elsif user.is_a? Barber
			can [:edit, :update], Profile, user_id: user.id
		elsif user.is_a? Client
			can [:edit, :update], Profile, user_id: user.id
			can :manage, ClientHairProperty, profile_id: user.profile.id
		end

		can :manage, Organization, user_id: user.id

		if organization = Organization.find_by(user_id: user.id)

			can :destroy, Membership, organization_id: organization.id
			cannot :destroy, Membership, user_id: user.id
		end

	end
end
