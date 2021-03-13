Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: {session: 'api/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, path: "/" do
    resources :users, only: [:show, :create, :update, :destroy]
  end
end
