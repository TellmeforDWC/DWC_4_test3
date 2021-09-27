Rails.application.routes.draw do
  root to: 'homes#top'

  get "home/about", to: "homes#about", as: "about_us"

  devise_for :users
  resources :books, :except => [:new, :destroy]
  delete "/books/:id", to: "books#destroy", as: "destroy_book"

  resources :users, only: [:show, :index, :edit, :update]

end
