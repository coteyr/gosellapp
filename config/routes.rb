Rails.application.routes.draw do
  resources :groups
  resources :users do
    get :become
  end
  resources :lists do
    get :reset
  end
  resources :imports
  resources :jobs
  resources :prospects do
    post "disposition"
    collection do
      post :import
      get :reset
      get :delete_list
      post :list_delete
    end
    resources :results, only: [:create, :edit, :update, :destroy]
  end

  devise_for :users, controllers: { registrations: 'registrations' }, path: 'u'
  root 'menu#index'
  get "menu" => "prospects#menu"
  get "update_accessible" => "results#update_accessible"
  get 'edit_contacts/:id' => 'prospects#edit_contacts', as: :edit_contacts
end
