Rails.application.routes.draw do
  resources :tweets
  post 'tweets/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
