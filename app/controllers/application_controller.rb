class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :get_laboratorio

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?


  def pundit_user
    def current_user.at_intranet?
      false
    end
    def current_user.at_lab
      @lab
    end
    current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :crmv, :cpf, :telefone, :endereco])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :crmv, :cpf, :telefone, :endereco])
  end

  private

  def get_laboratorio
    if request.domain == 'elasticbeanstalk.com'
      # acessando pelo aws
      # vilareal.mundovet.sa-east-1.elasticbeanstalk.com
      @subdomain = request.subdomain.split(".")[-3]
    else
      # http://lupa.lvh.me:3000/
      # http://vilareal.mundo.vet
      @subdomain = request.subdomain
    end
    @domain = request.domain
    @org = Organizacao.where(subdomain: @subdomain).take
    @lab = @org.nil?? nil : @org.laboratorio
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(root_path)
  end

end
