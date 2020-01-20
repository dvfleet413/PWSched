Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'pages/help'
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }
  get 'welcome/index'
  get '/calendar', to: 'shifts#calendar_view', as: 'calendar'

  resources :shifts

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  root 'welcome#index'
end
