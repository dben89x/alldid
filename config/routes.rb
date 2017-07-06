Rails.application.routes.draw do
	root to: 'home#index'

	devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}

	get 'faq' => 'home#faq'
	get 'about' => 'home#about'
	get 'search' => 'home#search'
	get 'admin' => 'home#admin'

	resources :styles
	resources :services
	resources :hair_properties
	resources :locations
	resources :ethnicities
	resources :schedules
	resources :events
	resources :memberships
	resources :organizations
	resources :barber_styles, only: [:create]
	resources :profiles, only: [:show, :update]
	resources :user_favorites, only: [:create, :destroy], path: 'favorites'
	resources :subscriptions, only: [:new, :create]
	resources :barbers, only: [:show]
	resources :endorsements, only: [:create, :destroy]

	get 'admin' => 'admin#dashboard'
	get 'calendar' => 'barbers#calendar'
	get 'schedule' => 'barbers#schedule'
	get 'appointments' => 'home#appointments'

	match 'pricing' => 'subscriptions#new', via: :get
	match 'favorites' => 'user_favorites#index', via: :get
	match 'profile' => 'profiles#edit', via: :get
	match 'dashboard' => 'organizations#edit', via: :get
	match 'stripe/hooks' => 'stripe_hooks#receive_webhooks', via: :post
	match 'hooks' => 'hooks#dispatch_event', via: :post

	put 'change_hair_properties' => 'hair_properties#change'

	post 'schedules' => 'barbers#create_schedule'
	post 'barber_services' => 'barber_services#create'
	post 'delete_favorite' => 'user_favorites#delete_favorite'
	post 'delete_barber_style' => 'barber_styles#delete_barber_style'
	post 'delete_barber_service' => 'barber_services#delete_barber_service'
	post 'delete_endorsement' => 'endorsements#delete_endorsement'

end
