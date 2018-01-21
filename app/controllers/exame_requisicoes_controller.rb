class ExameRequisicoesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_exame_requisicao, only: [:show, :edit, :update, :destroy]


  def show
    authorize @exame_requisicao
  end

  def edit
    authorize @exame_requisicao
  end

  
  def new
    @exame_requisicao = ExameRequisicao.new
  end
  
  def index
    @exame_requisicoes = ExameRequisicao.where(requisitante: current_user).order(:id).reverse_order
  end

  def create
    @exame_requisicao = ExameRequisicao.new(exame_requisicao_params)
    @exame_requisicao.laboratorio = @lab
    @exame_requisicao.requisitante = current_user
    @exame_requisicao.tipo = ExameTipo.find(params[:exame_requisicao][:tipo_id])

    if @exame_requisicao.save
      redirect_to @exame_requisicao, notice: 'Requisiçao de Exame criada com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /exame_requisicoes/1
  def update
    if @exame_requisicao.update(exame_requisicao_params)
      authorize @exame_requisicao
      redirect_to @exame_requisicao, notice: 'Requisiçao de Exame atualizada com sucesso.'
    else
      render :edit
    end

  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exame_requisicao
    @exame_requisicao = ExameRequisicao.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def exame_requisicao_params
    params.require(:exame_requisicao).permit(:proprietario, :nome, :idade, :especie, :raca, :observacoes, :tipo_id, :suspeita_clinica )
  end

end
