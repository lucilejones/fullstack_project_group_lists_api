Rails.application.routes.draw do
  resources :lists
  resources :users do
    get 'lists', to: 'users#lists_index'
  end
end
