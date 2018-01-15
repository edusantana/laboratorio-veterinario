module Intranet
  class LaboratoriosController < IntranetController
    def show
      authorize @lab
    end
  end
end
