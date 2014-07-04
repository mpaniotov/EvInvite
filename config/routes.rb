Rails.application.routes.draw do
  root :to => 'users#index'
  post 'auth_completion' => 'users/auth#create'
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
end
