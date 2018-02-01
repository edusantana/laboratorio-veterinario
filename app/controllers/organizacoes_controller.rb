class OrganizacoesController < ApplicationController

  def show
    if @org.clinica
      get_clinica
      render "clinicas/show", :layout => "clinica"
    else
      render "laboratorios/show"
    end
  end

  def criar_clinica_demo
    
    @org = Organizacao.criar_clinica_demo
    @clinica = @org.clinica

    redirect_to root_url(subdomain: @org.subdomain), notice: 'Clínica demonstrativa foi recriada.'
  end

end
