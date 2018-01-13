class IntranetController < ApplicationController

  before_action :authenticate_user!

  # FIXME verificar permissão de acessar a intranet

end

