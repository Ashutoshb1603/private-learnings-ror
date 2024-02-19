require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  root 'admin/dashboard#index'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :bx_block_catalogue do
    resources :brands, only: [:create, :index]
    resources :catalogues, only: [:index, :create, :show, :update, :destroy]
    resources :catalogues_variants_colors, only: [:create, :index]
    resources :catalogues_variants, only: [:create, :index]
    resources :catalogues_variants_sizes, only: [:create, :index]
    resources :reviews, only: [:create, :index]
    resources :tags, only: [:create, :index]
    resources :advertisements, only: [:index, :update]
    resources :products do
      collection do
        get :recommendation
        post :recommend_product
        get :hero_products
        post :set_as_favourite
        delete :remove_favourite
        get :favourites
        get :product_library
        get :refresh_products, format: :json
      end
    end
  end
  namespace :bx_block_categories do
    resources :categories, only: [:index, :create, :show, :update, :destroy]
    resources :sub_categories, only: [:index, :create, :show, :update, :destroy]
  end

  namespace :bx_block_data_import_export_csv do
    resources :export, only: :index
  end

  namespace :bx_block_push_notifications do
    resources :push_notifications, only: :create
  end

  namespace :bx_block_shopping_cart do
    get 'availabilities/get_booked_time_slots', to: 'availabilities#get_booked_time_slots'
    get "customer_appointments/customer_orders", to: 'customer_appointments#customer_orders'
    patch 'customer_appointments/update_notification_setting', to: 'customer_appointments#update_notification_setting'
    resources :orders, only: [:create, :show] do
      collection do
        get :past_orders
        put :cancel
        get :locations
      end
    end
    resources :cart_items do
      member do
        put :update_quantity
      end
      collection do
        get :get_taxes_and_shipping_charges
        post :apply_discount
      end
    end
    resources :service_provider_appointments, only: [] do
      collection do
        get :filter_order
        get :start_order
        get :finish_order
        get :get_sp_details
      end
    end
  end

  namespace :bx_block_roles_permissions do
  end

  namespace :bx_block_admin do
    resources :dashboards, only: [:index] do
      collection do
        get :user_counts
        get :advertisement_counts
        get :login_time
      end
    end
    resources :orders, only: [:index]
    resources :blogs, only: [:create] do
      collection do
        post :pin_or_unpin
      end
    end
    resources :users, only: :index do
      collection do
        patch :active
        patch :inactive
        put :upgrade_membership
        put :downgrade_membership
        get :elite_eligible_users
        put :block_or_unblock
      end
    end
    resources :skin_clinics
    resources :notification_periods, only: [:index, :update]
    namespace :posts_moderation do
      resources :bad_wordsets, only: [:index, :update]
      resources :offensive_comments, only: [:index, :show, :destroy] do
        member do
          put :approve
        end
      end
      resources :offensive_questions, only: [:index, :show, :destroy] do 
        member do
          put :approve
        end
      end
      resources :repeated_offenders, only: [:index, :update]
    end
    resources :user_analytics do 
      collection do 
        get :conversation_rates
        get :top_spenders
        get :top_favourites
      end
    end
    resources :consultation_analytics
    resources :page_clicks
    resources :top
    resources :notifications, only: [:create]
    resources :posts do
      collection do
        put :add_or_remove_recommendation
      end
    end
  end

  namespace :bx_block_appointment_management do
    resources :availabilities, only: [:index, :create] do
      delete :delete_all
    end
  end

  namespace :bx_block_scheduling do
    resources :service_provider_schedulings, only: [] do
      get :get_sp_details
    end
  end

  namespace :bx_block_notifications do
    resources :notifications, only: [:index, :create, :show, :update, :destroy] do
      collection do
        put :read_all
        delete :delete_all
      end
    end
    resources :notification_types, only: [:index] do
      member do
        post :enable_or_disable
      end
    end
  end

  namespace :bx_block_automatic_renewals do
    resources :automatic_renewals, only: [:index, :create, :show, :update]
  end

  namespace :bx_block_login do
    post '/login', to: 'logins#create'
  end

  namespace :account_block do
    resources :accounts, only: [:create, :update, :destroy] do
      member do
        put :renew_token
        delete :unsubscribe
        put :subscribe
        put :freeze_account
        put :unfreeze_account
        get :delete_confirmation_message
        get 'skin_journey/:skin_journey_id', to: 'accounts#skin_journey'
        put :add_sign_in_time
        put :add_sign_out_time
      end
      collection do
        post '/contact_us', to: 'accounts#contact_us'
      end
      get '', to: 'accounts#user_details'
      delete '/logout', to: 'accounts#logout'
    end
    get '/accounts', to: 'accounts#show'
    namespace :accounts do
      resources :country_code_and_flags, only: :show
      resources :email_confirmations, only: :show
      resources :account_delete, only: :show
      resources :send_otps, only: :create
      resources :sms_confirmations, only: :create
    end
    resources :therapist do 
      member do 
        get :clients
        put :pin_clients
        put :unpin_clients
        get :pinned_clients
        get 'view_client_notes/:client_id', to: 'therapist#view_client_notes'
        put :update_client_notes
        get 'client_details/:client_id', to: 'therapist#client_details'
        get '/consultation_form_show/:client_id', to: 'therapist#consultation_form_show'
        get '/skin_diary/:client_id', to: 'therapist#skin_diary'
        get '/quiz_answer/:client_id', to: 'therapist#quiz_answer'
        get '/skin_goal_answers/:client_id', to: 'therapist#skin_goal_answers'
        get '/user_skin_goals/:client_id', to: 'therapist#user_skin_goals'
        get '/available_dates', to: 'therapist#available_dates'
        get '/available_times', to: 'therapist#available_times'
        get '/appointments_list', to: 'therapist#apppointments_list'
        get '/monthly_skin_diary/:client_id', to: 'therapist#monthly_skin_diary'
        get '/weekly_skin_diary/:client_id', to: 'therapist#weekly_skin_diary'
        post '/skin_journey', to: 'therapist#skin_journey'
        get '/skin_logs/:client_id', to: 'therapist#skin_logs'
      end
    end
    resources :story do
      collection do
        get :my_stories
      end
    end
  end

  namespace :bx_block_facialtracking do
    resources :skin_quizzes, only: :index
    resources :account_choice_skin_quizzes, only: :create
    resources :account_choice_skin_logs, only: :create
    resources :user_images, only: :create
    get '/user_skin_logs', to: 'account_choice_skin_logs#show'
    get '/skin_goal_answers', to: 'account_choice_skin_logs#skin_goal_answers'
    get '/user_skin_goals', to: 'account_choice_skin_logs#user_skin_goals'
    get '/weekly_skin_diary', to: 'user_images#weekly_skin_diary'
    get '/skin_logs', to: 'user_images#skin_logs'
    get '/monthly_skin_diary', to: 'user_images#monthly_skin_diary'
    get '/sign_up_quiz_answer', to: 'account_choice_skin_quizzes#quiz_answer'
    get '/consultation_form_show', to: 'account_choice_skin_logs#consultation_form_show'
  end

  namespace :bx_block_livestreaming do 
    resources :twilio, only: [:create, :show, :destroy] do 
      collection do 
        put :end_video_chat
      end
    end
    resources :live_schedule
  end
  
  namespace :bx_block_event do
    resources :events, only: [:create, :index] do
      collection do
        delete :delete_event
      end
    end
    get '/life_events', to: 'events#life_events'
  end

  namespace :bx_block_appointment_management do
    resources :appointments do
      member do 
        post :video_room
        put :end_video_chat
      end
      collection do 
        get :admin_list
        get :therapists
        get :types
        get :customer_appointments
        get :therapist_appointments
        delete "cancel/:id", :to => "appointments#cancel"
        put "reschedule/:id", :to => "appointments#reschedule"
        get :available_dates
        get :available_times
      end
    end
  end

  namespace :bx_block_blogpostsmanagement do
    resources :blogs do
      member do
        get 'article/:article_id', :to => 'blogs#article'
      end
    end
  end

  namespace :bx_block_payments do
    resources :payments do
      collection do 
        get :my_wallet
        put :add_money
        patch :update_wallet
        put :use_money
        post :pay_with_card
        # post :refund_money
        post :send_gift
        post :submit
        get :plans
        get :list_cards
        get 'get_wallet_transaction/:id', :to => 'payments#get_wallet_transaction'
        post :paypal_generate_token
        put :upgrade_user
        get :execute
        get :cancel
        get :thank_you
        post :membership_update
        post :ipn_webhook
        post :paypal_webhook
      end
    end
    resources :paypal_response do
      collection do 
        get :success_response
        get :cancel_response
      end
    end
    resources :subscriptions
    resources :plans
    resources :gift_types, only: :index
  end

  namespace :bx_block_skin_diary do
    resources :skincare_routines do
      collection do
        get :get_routines
        delete "remove_product/:id", :to => "skincare_routines#remove_product"
        put 'remove_note/:id', :to => 'skincare_routines#remove_note'
      end
    end
    resources :skincare_steps, only: [:update, :create] do
      collection do
        delete 'delete_comment/:id', :to => 'skincare_steps#delete_comment'
      end
      member do
        put :upload_product
      end
    end
    resources :skin_stories
  end

  namespace :bx_block_communityforum do
    resources :groups
    resources :questions do 
      member do
        put :like
        put :saved
        post :comment
        post :report
      end
    end

    resources :comments do
      member do
        post :reply
        put :like
        post :report
      end
    end
    resources :profile do
      collection do
        get :saved
        get :my_activity
        get :activity
      end
    end
  end
  
  namespace :bx_block_explanation_text do
    resources :explanation_texts, only: :index
  end

  namespace :bx_block_skin_clinic do
    resources :skin_clinics, only: [:index, :show]
    resources :skin_treatment_locations, only: :index
  end

  namespace :bx_block_faqs do
    resources :faqs, only: :index
  end

  namespace :bx_block_consultation do
    resources :consultation_types, only: :index
    resources :user_consultations, only: :create
    get 'user_consultation', to: 'user_consultations#user_consultation'
  end

  namespace :admin do
    resources :featured_posts
  end

  namespace :bx_block_contentmanagement do
    resources :tutorials do 
      member do
        put :like
      end
    end
    resources :live_video do 
      member do
        put :like
      end
    end
    resources :academies do
      member do
        put :purchase
      end
    end
    resources :skin_hub, only: :index
    resources :search do 
      collection do
        post :search
        get :auto_suggest
      end
    end
    resources :home_page_views, only: :create
  end

  namespace :bx_block_livestreaming do
    resources :twilio
  end

  namespace :bx_block_chat do
    resources :chat, only: [:index, :show, :destroy] do
      member do 
        post :send_message
      end
      collection do
        get :create_chat
        put :disable_chats
        put :pin_or_unpin
        put :mark_unread
      end
    end
  end

end
