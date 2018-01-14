class ExameResultado < ApplicationRecord
  belongs_to :requisicao, class_name: "ExameRequisicao"
  belongs_to :tecnico, class_name: "User"
  has_many :anexos, class_name: "ExameAnexo", foreign_key: "resultado_id"
end
