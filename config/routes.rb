Rails.application.routes.draw do
  get 'web/bootstrap'
  get 'sessions/create'
  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :groups do
    # localhost:3000/groups/:id/join
    post 'join', to: 'groups#join'
    delete 'leave', to: 'groups#leave'
  end
  resources :items
  resources :invitations
  resources :lists

  resources :users do
    get 'lists', to: 'users#lists_index'
    get 'created_groups', to: 'users#created_groups_index'
    get 'joined_groups', to: 'users#joined_groups_index'
  end
end
