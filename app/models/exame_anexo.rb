class ExameAnexo < ApplicationRecord
  belongs_to :resultado, class_name: "ExameResultado"
  has_attached_file :anexo
  validates_attachment_content_type :anexo, content_type: { content_type: "application/pdf" }
end
