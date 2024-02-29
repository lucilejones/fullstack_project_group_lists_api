Rails.application.routes.draw do
  resources :lists, only: [:create, :update, :destroy]
  resources :users do
    get 'lists', to: 'users#lists_index'
  end
end
