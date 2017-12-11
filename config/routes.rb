Rails.application.routes.draw do
  devise_for :users
	root to: "home#show"

	resources :answers, only: [:update]
end
