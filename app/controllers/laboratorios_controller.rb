class LaboratoriosController < ApplicationController
  def show
    unless @lab
      render :inexistente
    end
  end
end
