class Laboratorio < ApplicationRecord
  has_many :exame_requisicoes
  has_many :exame_tipos
end
