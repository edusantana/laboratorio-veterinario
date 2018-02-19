Rails.application.routes.draw do

  namespace :intranet do
    get 'exame_resultados/new'
    get 'exame_resultados/edit'
  end

  constraints(subdomain: /^(?!mundo).+/) do
    
    resources :exame_tipos, except: [:show] do
      post 'edit_mode', on: :collection
      post 'leave_edit', on: :collection
    end
    resources :exame_requisicoes, except: [:destroy] do
      get 'novo_semelhante', on: :member
    end
    
    resources :familias, only: [:new, :edit] do
      post 'add_tutor', on: :member
      post 'add_paciente', on: :member
    end
    
    resources :pacientes, shallow: true do
      resources :atendimentos
    end

    resources :atendimentos, only: [:edit, :update] do
      
    end

    match '/', to: 'organizacoes#show', via: [:get]

    match '/iniciando_atendimento', to: 'atendimentos#iniciando', via: [:get], as: :iniciando_atendimento



    namespace :intranet do
      resources :exame_requisicoes, except: [:new, :create, :show, :destroy] do
        get 'receber', on: :member
        post 'anexar_resultado', on: :member
        post 'anexar_imagens', on: :member
        resources :exame_resultados, only: [:new, :create]
        get 'confirmar', on: :collection
        patch 'confirmar', on: :collection, action: :confirmar_recebimento
      end
      resources :exame_resultados, only: [:show, :edit, :update]

      match '/', to: 'laboratorios#show', via: [:get]
    end
  end

  resources :laboratorios, only: [:new, :create]


#  match '/', to: 'exame_requisicao#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]

  match '/criar_clinica_demo', to: 'organizacoes#criar_clinica_demo', via: [:get]
  match '/conceder_permissoes_ao_labdemo', to: 'organizacoes#conceder_permissoes_ao_labdemo', via: [:get]
  
  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
