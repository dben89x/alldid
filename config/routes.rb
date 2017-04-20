Rails.application.routes.draw do
	root to: 'home#index'
	get 'faq' => 'home#faq'
	get 'about' => 'home#about'
	get 'search' => 'home#search'
	get 'admin' => 'home#admin'

	resources :subscriptions, only: [:new, :create]
	match 'pricing' => 'subscriptions#new', via: :get

	devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}
	resources :profiles, only: [:show, :update]
	resources :user_favorites, only: [:create, :destroy], path: 'favorites'
	post 'delete_favorite' => 'user_favorites#delete_favorite'
	match 'favorites' => 'user_favorites#index', via: :get
	resources :barbers, only: [:show]
	match 'profile' => 'profiles#edit', via: :get
end
