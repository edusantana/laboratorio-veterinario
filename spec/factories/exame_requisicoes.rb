FactoryBot.define do
  factory :exame_requisicao, aliases: [:requisicao] do
    requisitante
    proprietario "Nome do proprietario"
    nome "AnimalNome"
    idade {[1,2,3,4,5,6].sample}
    especie "Especie1"
    raca "Raça1"
    laboratorio
    association :tipo, factory: :exame_tipo

    # after(:build) { |requisicao| requisicao.tipo.laboratorio =  requisicao.laboratorio}

    factory :exame_requisicao_aguardando_resultado do
      after(:build) { |requisicao| requisicao.confirmar_recebimento }
    end

    factory :exame_requisicao_com_resultado_disponivel do
      association :resultado, factory: :resultado_com_anexo
      before(:create) do |requisicao| 
        requisicao.resultado.requisicao = requisicao
        requisicao.confirmar_recebimento
        requisicao.resultado_inserido
      end
    end

  end
end
