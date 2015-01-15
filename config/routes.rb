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
      
      get 'events' => 'events#index', :as => 'events'
      get 'created_events' => 'events#created_index', :as => 'created_events'
      get 'attending_events' => 'attending_events#index', :as => 'attending_events'
      post 'events' => 'events#create'
      put 'events/:id/open' => 'events#open', :as => 'open_event'
      put 'events/:id/attend' => 'events#attend', :as => 'attend_event'
    
    end
  end

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
end