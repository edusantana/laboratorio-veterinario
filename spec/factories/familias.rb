FactoryBot.define do
  factory :familia do
    clinica nil

    factory :familia_simples do
      after(:build) do |familia|
        familia.tutores << build(:tutor)
        familia.pacientes << build(:paciente)
      end
    end
    
    factory :familia_composta do
      after(:build) do |familia|
        familia.tutores << build(:tutor, sexo: false)
        familia.tutores << build(:tutor, sexo: true)
        familia.pacientes << build(:paciente)
        familia.pacientes << build(:paciente)
      end
    end

  end
end
