Rails.application.routes.draw do
  root      'application#index'
  resource  :session
  resources :users
  resources :books
  resources :students

  get  '/login'    => 'session#new'
  post '/checkout' => 'books#checkout'
end
