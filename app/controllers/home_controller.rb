class HomeController < ApplicationController
  layout "labvet"

  def index
    @laboratorios = Laboratorio.all
  end
end
