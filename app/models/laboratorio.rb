class Laboratorio < ApplicationRecord
  has_many :exame_requisicoes
  has_many :exame_tipos

  belongs_to :dono, class_name: "User"
end
