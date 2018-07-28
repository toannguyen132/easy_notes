Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#new'

  get 'users/new' => 'users#new', as: :new_user

  post 'users' => 'users#create'

end
