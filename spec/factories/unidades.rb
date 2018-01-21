FactoryBot.define do
  factory :unidade do
    sequence(:nome) { |n| "Unidade #{n}" }
    laboratorio
    telefone { "(XX) XXXX-XXXX" }
    endereco { "R. Boa, N. infinito." }
  end
end
