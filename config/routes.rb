Rails.application.routes.draw do
  
  match '/', to: 'laboratorio#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]


  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
