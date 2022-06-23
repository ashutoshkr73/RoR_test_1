Rails.application.routes.draw do


  resources :users 
  # Defines the root path route ("/")
  root "static_pages#home"

  # mapping 
  get '/help' ,to: 'static_pages#help'
  get '/about',to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #define edit path of accountActivation
  resources  :account_activations , only: [:edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
