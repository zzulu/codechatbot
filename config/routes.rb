Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bots#index'
  devise_for :users
  
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
