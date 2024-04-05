Rails.application.routes.draw do
  get 'web/bootstrap'
  get 'sessions/create'
  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :groups
  resources :items
  resources :lists

  resources :users do
    get 'lists', to: 'users#lists_index'
    get 'created_groups', to: 'users#created_groups_index'
    get 'joined_groups', to: 'users#joined_groups_index'
  end
end
