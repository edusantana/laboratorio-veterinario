class TutoresController < ApplicationController


  def create
    @tutor = Tutor.create(tutor_params)

    if @tutor.save
      redirect_to @exame_requisicao, notice: 'Requisiçao de Exame criada com sucesso.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_exame_requisicao
  #  @exame_requisicao = ExameRequisicao.find(params[:id])
  # end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def tutor_params
    params.require(:tutor).permit(:nome, :telefones, :email, :cpf)
  end


end
