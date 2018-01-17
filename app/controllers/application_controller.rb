class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :get_laboratorio

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  
  def pundit_user
    def current_user.at_intranet?
      false
    end
    def current_user.at_lab
      @lab
    end
    current_user
  end
    
  private

  def get_laboratorio
    if ENV['RACK_ENV'] == 'production'
      # Exemplo: lupa.labvet.sa-east-1.elasticbeanstalk.com/
      # subdomain <- lupa
      @subdomain = request.subdomain.split(/\.labvet\./)[-2]
    else
      @subdomain = request.subdomain
    end
    
    @lab = Laboratorio.where(subdomain: @subdomain).take
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(root_path)
  end

end
