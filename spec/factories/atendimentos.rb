FactoryBot.define do
  factory :atendimento do
    anamnese "MyText"
    peso 1.5
    temperatura_retal 1.5
    batimentos_cardiaco 1.5
    frequencia_respiratoria 1.5
    observacoes "MyText"
    achados_clinicos "MyText"
    exames_complementares "MyText"
    diagnostico_presuntivo "MyText"
    terapia_do_presuntivo "MyString"
    diagnostico_definitivo "MyText"
    terapia_do_definitivo "MyText"
    paciente nil
  end
end
