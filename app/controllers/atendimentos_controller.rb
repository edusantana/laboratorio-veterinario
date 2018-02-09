class AtendimentosController < OrganizacoesController

  layout "clinica"

  before_action :authenticate_user!

  before_action :set_paciente, only: [:new, :create]
  before_action :set_atendimento, only: [:edit, :update]

  def new
    @atendimento = Atendimento.new(paciente: @paciente)
  end

  def edit
  end

  def create
    #byebug
    @atendimento = Atendimento.create(paciente: @paciente)
    @atendimento.update(create_params)

    if @atendimento.save
      redirect_to edit_atendimento_path(@atendimento)
    else
      render :new
    end
  end


  def update
    # https://www.railstutorial.org/book/updating_and_deleting_users
    @atendimento.update(update_params)
    redirect_to edit_atendimento_path(@atendimento), notice: "Atendimento salvo."
  end

  private

  def set_paciente
    if params[:paciente_id]
      @paciente = Paciente.find(params[:paciente_id])
    else
      @paciente = Paciente.find(params[:atendimento][:paciente_id])
    end
  end

  def set_atendimento
    @atendimento = Atendimento.find(params[:id])
  end

  def atendimento_params
    params.permit(:id).permit(:anamnese).permit(atendimento: [:anamnese])
  end

  def update_params
    params.require(:atendimento).permit([:anamnese, :peso, :temperatura_retal, :batimentos_cardiaco, :frequencia_respiratoria, :observacoes, :achados_clinicos, :exames_complementares, :diagnostico_presuntivo, :terapia_do_presuntivo, :diagnostico_definitivo, :terapia_do_definitivo])
  end


  def create_params
    params.require(:atendimento).permit([:anamnese])
  end
end
