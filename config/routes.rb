Rails.application.routes.draw do

  root to: 'pages#index'
  get 'u/:username'=> "pages#profile", as: :profile
  resources :communities do
    resources :posts
  end
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
