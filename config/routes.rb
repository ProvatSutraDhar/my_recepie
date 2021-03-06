Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'pages#home'

        resources :recipes do
          resources :comments, only:[:create]
        end

        get '/signup', to: 'chefs#new'
        resources :chefs, except: [:new]
        get '/login', to: 'session#new'
        post '/login', to: 'session#create'
        delete 'logout', to: 'session#destroy'

    resources :ingredients, except: [:destroy]

    mount ActionCable.server => '/cable'

    get '/chat', to: 'chatrooms#show'
    resources :messages ,only: [:create]
end
