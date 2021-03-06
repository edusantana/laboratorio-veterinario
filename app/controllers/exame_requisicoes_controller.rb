class ExameRequisicoesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_exame_requisicao, only: [:show, :edit, :update, :destroy, :novo_semelhante]


  def show
    authorize @exame_requisicao
  end

  def edit
    authorize @exame_requisicao
  end

  def new
    if current_user.nome.blank? || current_user.cpf.blank? || current_user.crmv.blank? || current_user.endereco.blank? || current_user.telefone.blank?
      redirect_to edit_user_registration_path, alert: "Atualize o perfil completo para poder solicitar exames."
    elsif @lab.exame_tipos.empty?
      redirect_to root_url(subdomain: @lab.organizacao.subdomain), alert: "Enquanto não houver tipos de exames cadastrados nesse laboratório não será possível solicitar novos exames."
    else
      @exame_requisicao = ExameRequisicao.new
    end
  end

  def novo_semelhante
    if current_user.nome.blank? || current_user.cpf.blank? || current_user.crmv.blank? || current_user.endereco.blank? || current_user.telefone.blank?
      redirect_to edit_user_registration_path, alert: "Atualize o perfil completo para poder solicitar exames."
    else
      @exame_requisicao = @exame_requisicao.dup
      render :new
    end
  end

  def index
    @exame_requisicoes = ExameRequisicao.where(requisitante: current_user, laboratorio: @lab).order(:id).reverse_order

    # não é necessário authorize, qualquer um pode consultar os seus exames
    #authorize @lab, :listar_requisicoes?
  end

  def create
    @exame_requisicao = ExameRequisicao.new(exame_requisicao_params)
    @exame_requisicao.laboratorio = @lab
    @exame_requisicao.requisitante = current_user
    @exame_requisicao.tipo = ExameTipo.find(params[:exame_requisicao][:tipo_id])

    authorize @exame_requisicao

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
