FactoryBot.define do

  sequence :subdomain do |n|
    "domain#{n}"
  end

  factory :laboratorio do
    nome "meulab"
    sequence(:apresentacao) {|n| "Texto#{n} de apresentação do laboratório." }
    organizacao

    factory :laboratorio_com_funcionarios do
      after(:create) do |lab|
        secretario = create(:user)
        tecnico = create(:user)
        secretario.add_role :secretario, lab.organizacao
        tecnico.add_role :tecnico, lab.organizacao
      end
    end

  end
end
