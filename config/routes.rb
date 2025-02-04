# config/routes.rb
Rails.application.routes.draw do
  get 'pages/index'
  root 'pages#index'
  namespace :api do
    namespace :v1 do
      post 'login', to: 'auth#create'
      delete 'logout', to: 'auth#destroy'

      # Admin endpoints
      resources :projects, only: [:index] do
        post 'assign', on: :member
        delete 'unassign', on: :member
        get 'task_breakdown', on: :member
      end

      # User endpoints
      resources :users, only: [] do
        get :assigned_projects, on: :collection
      end
      resources :tasks, only: [:create]
    end
  end
end