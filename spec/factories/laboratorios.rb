FactoryBot.define do

  sequence :subdomain do |n|
    "domain#{n}"
  end

  factory :laboratorio do
    nome "meulab"
    subdomain
    association :dono, factory: :user

    factory :laboratorio_com_funcionarios do
      after(:create) do |lab|
        secretario = create(:user)
        tecnico = create(:user)
        secretario.add_role :secretario, lab
        tecnico.add_role :tecnico, lab
      end
    end

    after(:build) {|lab| lab.dono.add_role :dono, lab}

  end
end
