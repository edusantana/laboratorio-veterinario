class HomeController < ApplicationController
  layout "mundovet"

  def index
    @experimentais = Organizacao.experimental
    @nao_experimentais = Organizacao.nao_experimental
  end
end
