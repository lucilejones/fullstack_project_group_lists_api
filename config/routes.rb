Rails.application.routes.draw do
  get 'sessions/create'
  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :groups
  resources :items
  resources :lists
  # TODO? add a get 'items', to: 'lists#items_index'
  # OR do a blueprint with the association items (for a long view)
  resources :users do
    get 'lists', to: 'users#lists_index'
  end
end
