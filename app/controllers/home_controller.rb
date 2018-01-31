class HomeController < ApplicationController
  layout "mundovet"

  def index
    @laboratorios = Laboratorio.all
  end
end
