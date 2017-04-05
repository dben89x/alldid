Rails.application.routes.draw do
	root to: 'home#index'
	get 'faq' => 'home#faq'
	get 'about' => 'home#about'
	get 'search' => 'home#search'

	devise_for :users

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
