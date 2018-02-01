class Clinica < ApplicationRecord
  belongs_to :organizacao

  alias :org :organizacao

  def demo?
    org.subdomain.equals('clinica')
  end

end
