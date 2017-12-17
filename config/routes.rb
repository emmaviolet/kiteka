Rails.application.routes.draw do
  resources :image_uploads
  	devise_for :users, controllers: { registrations: "registrations"}
	root to: "images#show"
	get "admin/download_data"
	resources :answers, only: [:create]
	resources :admin, only: [:index]
	resources :image_uploads
	resources :questions, only: [:create, :show]
	resources :allowed_users, only: [:create, :show]
end
