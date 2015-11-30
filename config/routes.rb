Rails.application.routes.draw do
  root      'application#index'
  resource  :session
  resources :users
  resources :books
  resources :students

  get  '/login'        => 'session#new'
  get  '/admin'        => 'application#admin'
  get  '/checkin'      => 'application#checkin'
  post '/checkin'      => 'books#checkin'
  post '/find_student' => 'students#find_student'
  post '/find_book'    => 'books#find_book'
  post '/checkout'     => 'books#checkout'
end
