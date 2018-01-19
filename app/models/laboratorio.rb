class Laboratorio < ApplicationRecord
  resourcify
  has_many :exame_requisicoes
  has_many :exame_tipos, -> { order('nome asc')}

  belongs_to :dono, class_name: "User"
end
