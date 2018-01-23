class Laboratorio < ApplicationRecord
  resourcify
  has_many :exame_requisicoes
  has_many :exame_tipos, -> { order('nome asc')}
  has_many :unidades, -> { order('nome asc')}

  belongs_to :dono, class_name: "User"

  # Não consegui implementar essa validação
  # validates :subdomain, format: { with: /[a-z\-\_0-9]+/, message: "only allows letters" }
end
