Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#new'

  get 'users/new' => 'users#new', as: :new_user

  post 'users', to: 'users#create'

  post 'register', to: 'users#create'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'profile' => 'users#profile'

end
