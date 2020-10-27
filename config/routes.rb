Rails.application.routes.draw do

  devise_for :users,controllers:{registrations:"users/registrations",sessions:"users/sessions"}
  devise_scope :user do
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
  end
  namespace :users do
    resources :shows, only: :show
    get "signout", to: "signouts#signout"
  end


  root "items#index"
  resources :items,except: :index do
    resources :payments, only: [:new, :create]
  end


  resources :categories, only: [:index, :show] do
    collection do
      get "ajax"
    end
  end


  resources :card, only: [:new, :create, :destroy]


  get "search", to: "searches#ajax"

end
