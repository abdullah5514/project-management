# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
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
