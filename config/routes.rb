Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'welcome/index'


  resources :shifts

  root 'welcome#index'
end
