DI::Application.routes.draw do

  namespace :donors do
    resources :donors
  end


  namespace :classroom do
    resources :schedules
  end


  namespace :theater do
    resources :showings
  end


  resources :videos


  namespace :ticketing do
    resources :tickets
  end


  namespace :ticketing do
    resources :events
  end


  resources :media


  namespace :table do
    resources :menus
  end


  namespace :table do
    resources :sites
  end


  get "screens/default"

  resources :events


  resources :sports


  resources :schools


  resources :categories


  resources :sections


  post "media/upload" => 'media#upload'

  get "screens/:action" => 'screens'
  get "screens/:action/:id" => 'screens'

  get '/admin' => 'table/sites#index'
  get '/admin/:action' => 'admin'

  root :to => "screens#default"

end
