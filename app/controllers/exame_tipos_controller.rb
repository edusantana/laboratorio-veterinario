class ExameTiposController < ApplicationController

  def edit_mode
    @exame_tipo = ExameTipo.new(laboratorio: @lab)
    authorize @exame_tipo
    @edit_mode = true
    render :exame_tipo_criacao
  end

  def leave_edit
    @exame_tipo = ExameTipo.new(laboratorio: @lab)
    # não requer authorize @exame_tipo
    @edit_mode = false
    render :exame_tipo_criacao
  end


  def create
    #@org = Organizacao.create!(subdomain: params[:subdomain], dono: current_user, experimental: true)
    #@lab = Laboratorio.create!(nome: params[:nome], organizacao: @org)

    #redirect_to root_url(subdomain: @org.subdomain)

    
    @exame_tipo = ExameTipo.new(exame_tipos_params)
    @exame_tipo.laboratorio = @lab
    authorize @exame_tipo
    @edit_mode = true
    if @exame_tipo.save
      render :exame_tipo_criacao
    else
      render 'new'
    end

  end

  def destroy
    @exame_tipo = ExameTipo.find(params[:id])
    authorize @exame_tipo
    @edit_mode = true
    if @exame_tipo.destroy
      render :exame_tipo_criacao
    end
  end

  private

  def exame_tipos_params
    params.require(:exame_tipo).permit([:nome, :valor])
  end


end
