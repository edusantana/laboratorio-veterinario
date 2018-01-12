Rails.application.routes.draw do
  
  
  constraints(subdomain: /^(?!labvet).*/) do
    resources :exame_requisicoes
    match '/', to: 'laboratorios#show', via: [:get, :post, :put, :patch, :delete]
  end

#  match '/', to: 'exame_requisicao#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]



  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
