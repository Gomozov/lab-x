LabX::Application.routes.draw do
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :sensors, :only => [:create, :index, :show]
  resources :reports, :only => [:create, :index, :show]

  root :to => 'pages#home'

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

end
