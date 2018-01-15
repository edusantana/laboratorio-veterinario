class IntranetController < ApplicationController

  before_action :authenticate_user!
  before_action :verifica_permissao_global

  def pundit_user
    def current_user.at_intranet?
      true
    end
    def current_user.at_lab
      @lab
    end
    current_user
  end

  private 
  
  def verifica_permissao_global
  end

end

