class FamiliasController < OrganizacoesController

  before_action :authenticate_user!
  before_action :set_familia, only: [:edit, :add_tutor, :add_paciente]


  layout 'clinica'
  
  def edit
    @tutor = Tutor.new
    @paciente = Paciente.new
  end

  def new
    @familia = Familia.create(clinica: @clinica)

    # Adicionar em última familia?

    redirect_to edit_familia_path(@familia)
  end

  def add_tutor
    @tutor = Tutor.new(tutor_params)
    @tutor.familia = @familia
    @tutor.save

    redirect_to edit_familia_path(@familia)
  end

  def add_paciente
    @paciente = Paciente.new(paciente_params)
    @paciente.familia = @familia
    if params['paciente']['sexo'] == 'masculino'
      @paciente.sexo = true
    else
      @paciente.sexo = false
    end
      
    @paciente.save

    redirect_to edit_familia_path(@familia)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_familia
    @familia = Familia.where(id: params[:id], clinica: @clinica).take
  end

  def tutor_params
    params.require(:tutor).permit(:nome, :telefones, :email, :cpf)
  end

  def paciente_params
    params.require(:paciente).permit(:nome, :raca, :especie, :data_nacimento, :sexo)
  end

end
