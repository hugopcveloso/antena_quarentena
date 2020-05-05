Rails.application.routes.draw do
	# ver se afecta
  # get 'comments/new'
  # get 'comments/create'
  root to: 'pages#index'
  get 'u/:username'=> "pages#profile", as: :profile
  resources :communities do
    resources :posts do
      resources :comments
    end
  end

  resources :comments do
    resources :comments
  end
  
  resources :votes
  resources :categories 

  resources :subscriptions
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
