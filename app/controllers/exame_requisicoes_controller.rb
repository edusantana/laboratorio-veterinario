class ExameRequisicoesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_exame_requisicao, only: [:show, :edit, :update, :destroy]


  def show
  end

  def edit
  end

  
  def new
    @exame_requisicao = ExameRequisicao.new
  end
  
  def index
    @exame_requisicoes = ExameRequisicao.where(requisitante: current_user)
  end

  def create    
    @exame_requisicao = ExameRequisicao.new(exame_requisicao_params)
    @exame_requisicao.laboratorio = @lab
    @exame_requisicao.requisitante = current_user
    @exame_requisicao.tipo = ExameTipo.last # FIXME

    if @exame_requisicao.save
      redirect_to @exame_requisicao, notice: 'Exame requisicao was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /exame_requisicoes/1
  def update
    if @exame_requisicao.update(exame_requisicao_params)
      redirect_to @exame_requisicao, notice: 'Exame requisicao was successfully updated.'
    else
      render :edit
    end

  end

  def destroy
    @exame_requisicao.destroy
    redirect_to exame_requisicoes_url, notice: 'Requisição de exame foi excluída com sucesso.'    
  end

  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exame_requisicao
    @exame_requisicao = ExameRequisicao.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def exame_requisicao_params
    params.require(:exame_requisicao).permit(:proprietario, :nome, :idade, :especie, :raca, :observacoes)
  end

end
