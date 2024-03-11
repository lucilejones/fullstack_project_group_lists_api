Rails.application.routes.draw do
  resources :items
  resources :lists
  # TODO? add a get 'items', to: 'lists#items_index'
  resources :users do
    get 'lists', to: 'users#lists_index'
  end
end
