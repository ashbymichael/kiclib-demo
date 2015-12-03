Rails.application.routes.draw do
  root      'library#index'
  resource  :session
  resources :users
  resources :books
  resources :students

  get  '/login'        => 'sessions#new'
  get  '/logout'       => 'sessions#destroy'
  get  '/admin'        => 'library#admin'
  get  '/checkin'      => 'library#checkin'
  get  '/checkout'     => 'library#index'
  post '/checkin'      => 'books#checkin'
  post '/find_student' => 'students#find_student'
  post '/find_book'    => 'books#find_book'
  post '/checkout'     => 'books#checkout'
end
