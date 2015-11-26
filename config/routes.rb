Rails.application.routes.draw do
  root      'application#index'
  resource  :session
  resources :users
  resources :books
  resources :students

  get  '/login'        => 'session#new'
  post '/find_student' => 'students#find_student'
  post '/checkout'     => 'books#checkout'
end
