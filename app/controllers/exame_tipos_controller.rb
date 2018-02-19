class ExameTiposController < ApplicationController


  def create
    #@org = Organizacao.create!(subdomain: params[:subdomain], dono: current_user, experimental: true)
    #@lab = Laboratorio.create!(nome: params[:nome], organizacao: @org)

    #redirect_to root_url(subdomain: @org.subdomain)

    
    @exame_tipo = ExameTipo.new(exame_tipos_params)
    @exame_tipo.laboratorio = @lab
    authorize @exame_tipo
    if @exame_tipo.save
      render :exame_tipo_criacao
    else
      render 'new'
    end

  end

  def destroy
    @exame_tipo = ExameTipo.find(params[:id])
    authorize @exame_tipo
    if @exame_tipo.destroy
      render :exame_tipo_criacao
    end
  end

  private

  def exame_tipos_params
    params.require(:exame_tipo).permit([:nome, :valor])
  end


end
