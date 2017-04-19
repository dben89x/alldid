Rails.application.routes.draw do
	root to: 'home#index'
	get 'faq' => 'home#faq'
	get 'about' => 'home#about'
	get 'search' => 'home#search'
	get 'admin' => 'home#admin'

	resources :subscriptions, only: [:new, :create]
	match 'pricing' => 'subscriptions#new', via: :get

	devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}
	resources :profiles, only: [:show, :edit, :update]
	resources :user_favorites, only: [:create]
end
