Imin::Application.routes.draw do

  resources :flights


  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  devise_for :users

  authenticated :user do
    root to: "users#current_user_show"
  end

  unauthenticated :user do
    root to: "users#index"
  end

  devise_scope :user do
    post 'registrations' => 'registrations#create', :as => 'register'
    post 'sessions' => 'sessions#create', :as => 'login'
    delete 'sessions' => 'sessions#destroy', :as => 'logout'

  end

  resources :users

  get 'tasks' => 'tasks#index', :as => 'tasks'
  post 'tasks' => 'tasks#create'
  put 'tasks/:id/open' => 'tasks#open', :as => 'open_task'
  put 'tasks/:id/complete' => 'tasks#complete', :as => 'complete_task'

  get 'invited_events/:user_id' => 'events#index', :as => 'invited_events'
  get 'created_events/:user_id' => 'events#created_index', :as => 'created_events'
  get 'attending_events/:user_id' => 'events#attending_index', :as => 'attending_events'
  get 'not_attending_events/:user_id' => 'events#not_attending_index', :as => 'not_attending_events'
  post 'events' => 'events#create'

  get 'invitations' => 'invitations#index', :as => 'invitations'
  post 'invitation' => 'invitations#index_specific', :as => 'invitation'
  post 'accept_invitation' => 'invitations#accept', :as => 'accept_invitation'
  post 'reject_invitation' => 'invitations#reject', :as => 'reject_invitation'
  post 'invitations' => 'invitations#create'

  get 'followers' => 'users#followers', :as => 'followers'
  get 'following' => 'users#following', :as => 'following'
  post 'follow' => 'users#follow', :as => 'follow'
  post 'unfollow' => 'users#unfollow', :as => 'unfollow'

  get 'registered_courses' => 'courses#index_specific', :as => 'registered_courses'
  get 'students' => 'courses#students', :as => 'students'
      # get 'specific_course' => 'courses#specific_course', :as => 'specific_course'

      # resources :conversations do
      #   resources :messages
      # end
      post 'messages' => 'messages#index', :as => 'messages'
      get 'messages' => 'messages#create', :as => 'create_message'

      get 'conversations' => 'conversations#index', :as => 'conversations'
      post 'conversations' => 'conversations#create', :as => 'create_conversation'



  # namespace :api do
  #   namespace :v1 do
  #     devise_scope :user do
  #       post 'registrations' => 'registrations#create', :as => 'register'
  #       post 'sessions' => 'sessions#create', :as => 'login'
  #       delete 'sessions' => 'sessions#destroy', :as => 'logout'

  #       root to: "devise/sessions#new"
  #     end


  #     get 'tasks' => 'tasks#index', :as => 'tasks'
  #     post 'tasks' => 'tasks#create'
  #     put 'tasks/:id/open' => 'tasks#open', :as => 'open_task'
  #     put 'tasks/:id/complete' => 'tasks#complete', :as => 'complete_task'

  #     get 'invited_events' => 'events#index', :as => 'invited_events'
  #     get 'created_events' => 'events#created_index', :as => 'created_events'
  #     get 'attending_events' => 'events#attending_index', :as => 'attending_events'
  #     post 'events' => 'events#create'

  #     get 'invitations' => 'invitations#index', :as => 'invitations'
  #     post 'invitation' => 'invitations#index_specific', :as => 'invitation'
  #     post 'accept_invitation' => 'invitations#accept', :as => 'accept_invitation'
  #     post 'reject_invitation' => 'invitations#reject', :as => 'reject_invitation'
  #     post 'invitations' => 'invitations#create'

  #     get 'followers' => 'users#followers', :as => 'followers'
  #     get 'following' => 'users#following', :as => 'following'
  #     post 'follow' => 'users#follow', :as => 'follow'
  #     post 'unfollow' => 'users#unfollow', :as => 'unfollow'

  #     get 'registered_courses' => 'courses#index_specific', :as => 'registered_courses'
  #     get 'students' => 'courses#students', :as => 'students'
  #     # get 'specific_course' => 'courses#specific_course', :as => 'specific_course'

  #     # resources :conversations do
  #     #   resources :messages
  #     # end
  #     post 'messages' => 'messages#index', :as => 'messages'
  #     get 'messages' => 'messages#create', :as => 'create_message'

  #     get 'conversations' => 'conversations#index', :as => 'conversations'
  #     post 'conversations' => 'conversations#create', :as => 'create_conversation'

  #     root to: 'users#index'
  #   end
  # end

  #     get 'tasks' => 'tasks#index', :as => 'tasks'

end