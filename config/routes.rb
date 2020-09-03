Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html¥

  root 'homes#top'

  get '/home/about' => 'homes#about'

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do

  	resources :book_comments, only: [:create, :destroy]

  	resource :favorites, only: [:create, :destroy]

  end

end