class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_laboratorio

  private

  def get_laboratorio
    @lab = Laboratorio.where(subdomain: request.subdomain).take
  end

end
