Rails.application.routes.draw do
  get 'welcome/index'

  resources :shifts

  root 'welcome#index'
end
