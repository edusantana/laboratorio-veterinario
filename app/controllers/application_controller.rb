class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_laboratorio

  private

  def get_laboratorio
    subdomain = request.subdomain.end_with?(".labvet.us-east-1") ? request.subdomain[0..-18] : request.subdomain
    @lab = Laboratorio.where(subdomain: subdomain).take
  end

end
