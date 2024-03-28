Rails.application.routes.draw do
  get 'web/bootstrap'
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
    get 'created_groups', to: 'users#groups_index'
  end
end
