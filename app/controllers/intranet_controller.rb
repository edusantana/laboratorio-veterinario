class IntranetController < ApplicationController

  before_action :authenticate_user!
  before_action :verifica_permissao_global


  # FIXME verificar permissão de acessar a intranet

  private 
  
  def verifica_permissao_global
  end

end

