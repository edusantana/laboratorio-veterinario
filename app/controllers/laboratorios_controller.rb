class LaboratoriosController < ApplicationController
  def show
    unless @lab
      #@subdomain = request.subdomain
      render :inexistente
    end
  end

  def new
    
  end

  def create
    @org = Organizacao.create!(subdomain: params[:subdomain], dono: current_user, experimental: true)
    @lab = Laboratorio.create!(nome: params[:nome], organizacao: @org)

    redirect_to root_url(subdomain: @org.subdomain)
  end

  private

  def create_params
    params.require([:nome, :subdomain]).permit([:exames, :apresentacao, :telefone])
  end


end
