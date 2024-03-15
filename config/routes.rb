Rails.application.routes.draw do
  get 'sessions/create'
  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :items
  resources :lists
  # TODO? add a get 'items', to: 'lists#items_index'
  resources :users do
    get 'lists', to: 'users#lists_index'
  end
end
