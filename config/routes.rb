Rails.application.routes.draw do
  resources :image_uploads
  	devise_for :users, controllers: { registrations: "registrations"}
	root to: "home#show"
	resources :answers, only: [:create]
	resources :admin, only: [:index]
	resources :questions, only: [:create, :destroy]
	resources :allowed_users, only: [:create, :destroy]
end
