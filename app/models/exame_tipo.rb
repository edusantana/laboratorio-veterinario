class ExameTipo < ApplicationRecord
  belongs_to :laboratorio
  has_many :requisicoes, class_name: "ExameRequisicao", foreign_key: "tipo_id"
end
