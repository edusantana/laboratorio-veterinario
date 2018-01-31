class ExameAnexo < ApplicationRecord
  belongs_to :resultado, class_name: "ExameResultado"
  # Token para ofuscar url de download
  # https://github.com/thoughtbot/paperclip/wiki/Interpolations
  #
  has_secure_token :access_token
  
  has_attached_file :anexo, url: ":organizacao_id/:mes/resultados/:resultado_id/:class/:id/:access_token/:filename"

  validates_attachment_content_type :anexo, content_type: /.*pdf/

end
