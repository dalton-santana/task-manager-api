Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: {session: 'api/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, path: "/" do
    resources :users, only: [:show, :create, :update, :destroy]
    resources :sessions, only: [:create, :destroy]
    resources :tasks, only: [:index, :show, :create, :update, :destroy ]
    get '/all_public_tasks', to: 'tasks#all_public_tasks'
  end
end
