FactoryBot.define do
  factory :exame_requisicao do
    requisitante
    proprietario "Nome do proprietario"
    nome "AnimalNome"
    idade {[1,2,3,4,5,6].sample}
    especie "Especie1"
    raca "Raça1"
    laboratorio
    association :tipo, factory: :exame_tipo

    factory :exame_requisicao_aguardando_resultado do
      after(:build) { |requisicao| requisicao.confirmar_recebimento }
    end

  end
end
