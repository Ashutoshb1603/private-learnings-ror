require 'sidekiq/web'
Rails.application.routes.draw do
  get 'equipment/create'
  get 'equipment/index'
  get 'equipment/destroy'
  get 'club_events/create'
  get 'social_clubs/create'
  scope "(:locale)", locale: /#{ I18n.available_locales.join("|")}/ do 
    mount Sidekiq::Web => '/sidekiq'
    get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
   
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :account_block do
      resource :accounts, only: [:index, :create , :update] do 
        collection do 
          post :add_user_location
          get :get_user_location
          patch :update_interests
          get :get_profile
          delete :remove_interests
          patch :confirm_otp_and_update_email
          post :resend_otp_to_new_email
          post :resend_otp_to_current_email
          post :confirm_otp_email_of_current_user
          get :currency_codes
        end
      end
      resources :devices, only: [:destroy, :create, :index]
      namespace :accounts do 
      #   resource :sms_confirmations, only: [:create]  
        resource :otp_confirmations, only: [:create]
        resource :passwords, only: [:create]
        resource :resend_otp_validations, only: [:create]  
      #   resource :country_code_and_flags, only: [:show] do 
      #     collection do 
      #       get :get_country_list 
      #     end
      #   end
      end
    end

    namespace :bx_block_login do
      resources :logins, only: [:create]
      resource :logouts, only: [:destroy]
    end

    namespace :bx_block_interest do 
      resource :interests, only: [:create, :index] do 
        collection do 
          get :get_interests
        end
      end
    end

    namespace :bx_block_equipments do 
      resources :equipments
    end

    namespace :bx_block_forgot_password do
      resource :otps, only: [:create]
      resource :otp_confirmations, only: [:create]
      resource :passwords, only: [:create]
    end

    namespace :bx_block_admin do 
      get :terms_and_conditions, controller: "contents"
      post :contact_us, controller: "contents"
    end

    namespace :bx_block_push_notifications do
      resources :push_notifications do 
        collection do 
          get :any_unread_msg
          put :mark_read
          put :mark_unread
          # get :get_notifications_list
        end
      end
    end

    namespace :bx_block_hidden_places do 
      resources :hidden_places do 
        collection do 
          get :my_places
          get :search_by_activity
          get :search_by_travel_item
          get :search_by_weather
          get :search
          get :events_around_the_place
        end
      end
    end

    namespace :bx_block_social_clubs do
      get :upcoming_events, controller: "club_events"
      get :search_events_by_params, controller: "club_events"
      resources :social_clubs do
        collection do
          get :approved_social_clubs
          get :my_social_clubs
          get :existing_joined_clubs
          get :club_events
          get :place_lists
        end
        resources :club_events do
          collection do
            get :approved_events
            get :my_events
            get :search_event_by_location
          end
        end
      end

      resources :account_social_clubs do
        collection do
          delete :delete_participants
        end
      end
    end

    namespace :bx_block_eventregistration do
      resources :event_blocks
      resources :account_event_blocks, only: [:create]
      resources :club_event_accounts do
        collection do
          get :my_tickets
          get :ticket_details
        end
      end
    end

    namespace :bx_block_categories do
      resources :activities
      resources :weathers
      resources :travel_items
    end
    namespace :bx_block_feature_settings do 
      resource :change_passwords, only: [:update]
      resource :logouts, only: [:destroy]
      resource :delete_accounts, only: [:destroy]
    end

    namespace :bx_block_posts do
      resources :home do
        collection do
          get :search
          get :get_search_histories
          get :auto_suggestion_list
          get :search_by_location
          get :clear_history
        end
      end
    end

    namespace :bx_block_chat do
      resources :flagged_messages, only: [:create, :index] do
        collection do
          delete :unflag_message
        end
      end
      resources :chats do
        collection do
          get :get_access_token
          get :get_chat_media
        end
      end
      resources :messages do
        collection do
          get :get_messages
        end
      end
    end

    # namespace :bx_block_location do 
    #   resources :cities, only: [:index] do 
    #     collection do 
    #       get :search_city
    #     end
    #   end
    # end
  end
end
