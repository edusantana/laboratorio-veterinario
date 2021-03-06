class ExameRequisicao < ApplicationRecord
  belongs_to :requisitante, class_name: "User"
  belongs_to :tipo, class_name: "ExameTipo"
  belongs_to :laboratorio
  has_one :resultado, class_name: "ExameResultado", foreign_key: "requisicao_id"


  include AASM

  aasm do
    state :aguardando_envio, :initial => true
    state :aguardando_resultado
    state :resultado_disponivel
    state :arquivado
    state :cancelado

    event :confirmar_recebimento do
      transitions :from => :aguardando_envio, :to => :aguardando_resultado
    end

    event :resultado_inserido do
      transitions :from => :aguardando_resultado, :to => :resultado_disponivel
    end

    event :arquivar do
      transitions :from => :resultado_disponivel, :to => :arquivado
    end

    event :cancelar do
      transitions :from => :aguardando_envio, :to => :cancelado
    end

  end

end
