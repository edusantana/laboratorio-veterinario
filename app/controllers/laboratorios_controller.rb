class LaboratoriosController < OrganizacoesController
  def show
    unless @lab
      #@subdomain = request.subdomain
      render :inexistente
    end
  end
end
