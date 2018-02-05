class OrganizacoesController < ApplicationController

  before_action :get_clinica

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

end
