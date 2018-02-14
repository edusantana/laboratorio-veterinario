class OrganizacoesController < ApplicationController

  before_action :get_clinica
  before_action :authenticate_user!, only: [:conceder_permissoes_ao_labdemo]

  def show
    if @org
      if @org.clinica
        get_clinica
        render "clinicas/show", :layout => "clinica"
      else
        render "laboratorios/show"
      end
    else
      render :disponivel
    end
  end

  def criar_clinica_demo
    
    @org = Organizacao.criar_clinica_demo
    @clinica = @org.clinica

    redirect_to root_url(subdomain: @org.subdomain), notice: 'Clínica demonstrativa foi recriada.'
  end

  def conceder_permissoes_ao_labdemo
    org = Organizacao.where(subdomain: 'labdemo').take
    current_user.add_role :secretario, org
    current_user.add_role :tecnico, org

    redirect_to intranet_url(subdomain: org.subdomain), notice: 'Você recebeu permissão de secretário e técnico e acesso à Intranet do laboratório demonstrativo.'

  end


end
