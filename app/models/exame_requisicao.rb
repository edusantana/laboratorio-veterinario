class ExameRequisicao < ApplicationRecord
  belongs_to :requisitante, class_name: "User"
  belongs_to :tipo, class_name: "ExameTipo"
  belongs_to :laboratorio
end
