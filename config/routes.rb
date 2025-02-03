# config/routes.rb
Rails.application.routes.draw do
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
      resources :tasks, only: [:create]
      get 'my_projects', to: 'projects#assigned_projects'
    end
  end
end