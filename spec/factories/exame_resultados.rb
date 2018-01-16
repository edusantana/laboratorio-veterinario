FactoryBot.define do
  factory :exame_resultado do
    requisicao
    association :tecnico, factory: :user
    factory :resultado_com_anexo do
      after(:build) do |resultado| 
        anexo = build(:anexo, resultado: resultado)
        resultado.anexos << anexo
      end      
    end
  end
end
