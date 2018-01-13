FactoryBot.define do


  sequence :subdomain do |n|
    "domain#{n}"
  end

  factory :laboratorio do
    nome "meulab"
    subdomain
    association :dono, factory: :user
  end
end
