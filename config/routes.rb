Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  devise_for :users, controllers: {'registrations': 'users/registrations'}

  devise_scope :user do
    root to: 'devise/sessions#new'
    post 'users/disconnect', to: 'users/registrations#disconnect'
  end

  get 'account_connection', to: 'bots#account_connection', as: :account_connection

  get 'keyboard', to: 'api#keyboard'
  post 'message', to: 'api#message'
  post 'friend', to: 'api#create_friend'
  delete 'friend/:user_key', to: 'api#destroy_friend'
  delete 'chat_room/:user_key', to: 'api#chat_room'

  resources :bots do
    collection do
      post 'run_code', to: 'bots#run_code'
    end
  end

  # Write routes here about gemfiles
end
