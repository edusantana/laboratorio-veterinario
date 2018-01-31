Rails.application.routes.draw do
  

  namespace :intranet do
    get 'exame_resultados/new'
  end

  namespace :intranet do
    get 'exame_resultados/edit'
  end

  constraints(subdomain: /^(?!mundo).+/) do
    resources :exame_requisicoes, except: [:destroy] do
      get 'novo_semelhante', on: :member
    end
    match '/', to: 'laboratorios#show', via: [:get]

    namespace :intranet do
      resources :exame_requisicoes, except: [:new, :create, :show, :destroy] do
        get 'receber', on: :member
        post 'anexar_resultado', on: :member
        post 'anexar_imagens', on: :member
        resources :exame_resultados, only: [:new, :create]
      end
      resources :exame_resultados, only: [:show, :edit, :update]

      match '/', to: 'laboratorios#show', via: [:get]
    end
  end

#  match '/', to: 'exame_requisicao#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]

  get '/clinica', controller: :clinicas, action: :show

  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
