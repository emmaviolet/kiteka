Rails.application.routes.draw do
  devise_for :users
	root to: "home#show"

	resources :answers, only: [:create]
	resources :admin, only: [:index]
	resources :questions, only: [:create, :destroy]
	resources :allowed_users, only: [:create, :destroy]
end
