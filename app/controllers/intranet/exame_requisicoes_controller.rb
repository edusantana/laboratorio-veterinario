module Intranet

  class ExameRequisicoesController < IntranetController

    before_action :authenticate_user!
    before_action :set_exame_requisicao, only: [:show, :edit, :update, :destroy, :receber, :anexar_resultado, :anexar_imagens, :confirmar_recebimento]    

    def edit
    end

    def anexar_resultado

      @exame_requisicao.resultado ||= ExameResultado.create(requisicao: @exame_requisicao, tecnico: current_user)

      #byebug

      #params[:exame_anexo][:anexo].each do |anexo|
      #  @exame_requisicao.resultado.anexos.create(anexo)
      #end
      #params[:images].each { |image|  @gallery.pictures.create(image: image) }

      anexo = @exame_requisicao.resultado.anexos.create(anexo_params)

      @exame_requisicao.resultado_inserido! unless  @exame_requisicao.resultado_disponivel?

      redirect_to edit_intranet_exame_requisicao_path(@exame_requisicao), notice: 'Anexo adicionado.'
    end


    def anexar_imagens
      @exame_requisicao.resultado ||= ExameResultado.create(requisicao: @exame_requisicao, tecnico: current_user)
      
      imagem_params.each do |imagem|
        img = @exame_requisicao.resultado.imagens.create(imagem: imagem)
      end

      redirect_to edit_intranet_exame_requisicao_path(@exame_requisicao), notice: 'Imagens adicionadas.'
    end

    def receber
      @exame_requisicao.confirmar_recebimento!
      redirect_to intranet_exame_requisicoes_path, notice: "O recebimento foi confirmado."
    end
    
    def index
      @exame_requisicoes = ExameRequisicao.where(laboratorio: @lab).order(:id).reverse_order
    end

    def confirmar
      @exame_requisicoes = ExameRequisicao.where(laboratorio: @lab, aasm_state: 'aguardando_envio' ).order(:id)
    end

    def confirmar_recebimento
      @exame_requisicao.confirmar_recebimento!
      #redirect_to confirmar_intranet_exame_requisicoes_path
    end

    # PATCH/PUT /exame_requisicoes/1
    def update
      if @exame_requisicao.update(exame_requisicao_params)
        redirect_to @exame_requisicao, notice: 'Exame requisicao was successfully updated.'
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
      params.require(:exame_requisicao).permit(:proprietario, :nome, :idade, :especie, :raca, :observacoes)
    end

    def anexo_params
      #params.require(:anexo)
      params.require(:exame_anexo).permit(:anexo)
    end
    def imagem_params
      #params.require(:anexo)
      params.require(:imagens)

    end

  end

end