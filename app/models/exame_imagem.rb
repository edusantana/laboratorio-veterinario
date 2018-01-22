class ExameImagem < ApplicationRecord
  belongs_to :resultado, class_name: "ExameResultado"
  has_secure_token :access_token
  has_attached_file :imagem, url: ":subdomain/:mes/resultados/:resultado_id/:class/:id/:access_token/:filename"


  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\z/
end
