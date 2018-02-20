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
    @lab = Laboratorio.create!(nome: params[:nome], organizacao: @org, apresentacao: params[:apresentacao])
    @unidade = Unidade.create(laboratorio: @lab, telefone: params[:unidade][:telefone], nome:  params[:unidade][:nome], endereco: params[:unidade][:endereco])
    
    # não é necessário authorize, qualquer um pode criar

    if params[:exames]
      params[:exames].each_line do |nome|
        ExameTipo.create(laboratorio: @lab, nome: nome)
      end
    end

    redirect_to root_url(subdomain: @org.subdomain)
  end

  def update_apresentacao
    authorize @lab, :update?
    #byebug
    @lab.apresentacao = params[:laboratorio][:apresentacao]
    @lab.save
  end

  private

  def create_params
    params.require([:nome, :subdomain]).permit([:exames, :apresentacao, :telefone])
  end


end
