Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [ :index, :show, :new, :create ] do
    resources :goals, only: [:new]
  end

  resource :session, only: [ :new, :create, :destroy ]
  resources :goals, only: [:show, :create, :edit, :update, :destroy]
end
