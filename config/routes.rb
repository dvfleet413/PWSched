Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :shifts

  root 'welcome#index'
end
