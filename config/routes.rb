Rails.application.routes.draw do
  get 'pages/help'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'welcome/index'
  post '/button', to: 'shifts#weekly_email_prep', as: 'button'

  resources :shifts


  root 'welcome#index'
end
