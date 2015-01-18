Imin::Application.routes.draw do

  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
      get 'tasks' => 'tasks#index', :as => 'tasks'
      post 'tasks' => 'tasks#create'
      put 'tasks/:id/open' => 'tasks#open', :as => 'open_task'
      put 'tasks/:id/complete' => 'tasks#complete', :as => 'complete_task'
      
      get 'invited_events' => 'events#index', :as => 'invited_events'
      get 'created_events' => 'events#created_index', :as => 'created_events'
      get 'attending_events' => 'events#index', :as => 'attending_events'
      post 'events' => 'events#create'
      put 'events/:id/open' => 'events#open', :as => 'open_event'
      put 'events/:id/attend' => 'events#attend', :as => 'attend_event'

      get 'followers' => 'users#followers', :as => 'followers'
      get 'following' => 'users#following', :as => 'following'
      post 'follow' => 'users#follow', :as => 'follow'
      post 'unfollow' => 'users#unfollow', :as => 'unfollow'
     
    end
  end

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
end