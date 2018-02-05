class Familia < ApplicationRecord
  belongs_to :clinica

  has_many :tutores
  has_many :pacientes
end
