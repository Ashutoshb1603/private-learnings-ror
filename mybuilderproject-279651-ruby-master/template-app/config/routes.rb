Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :account_block do 
    resource :accounts, only: [:create] 
    
    namespace :accounts do
      resources :verification, only: [:create]
      get :get_country_list
    end
  end

  namespace :bx_block_login do
    resource :logins
    resource :confirmations
    resource :sms_confirmations
  end

  namespace :bx_block_privacy_settings do
    resource :terms_and_conditions
    resource :privacy_policies
  end

  namespace :bx_block_landingpage do
    resource :landingpages
  end

  namespace :bx_block_contact_us do
    resources :contacts
  end

  namespace :bx_block_posts do
    resources :posts
    get 'get_airports', to: 'posts#get_airports'
    get 'get_airport_agent', to: 'posts#get_airport_agent'
  end

  namespace :bx_block_inventorymanagement2 do
    resources :leons do
      collection do
        get 'authenticate_user'
        get 'leon_auth_data'
      end
    end
    resources :flights
    get 'get_flights', to: 'flights#get_flights'
    get 'get_quote_bookings', to: 'flights#get_quote_bookings'
  end

  namespace :bx_block_cfflexapi2 do
    resources :flexapis, only: [] do
      collection do
        post :store_aircraft_data
        post :store_crew_data
        post :store_airport_data
      end
    end
  end

  namespace :bx_block_cfaviapi2 do
    resources :aviapis, only: [] do
      collection do
        post :store_aircraft_data
      end
    end
  end

  namespace :bx_block_cfaviaapi2 do
    resources :aviapages
    post 'create_aviapages' , to: 'aviapages#create_aviapages'
  end

  namespace :bx_block_cfrdcenroutechargesapi do
    resources :enroute_charges do
      post :create_enroute_charge, on: :collection
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
