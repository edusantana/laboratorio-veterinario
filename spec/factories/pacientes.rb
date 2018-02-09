FactoryBot.define do
  factory :paciente do
    nome "MyString"
    sexo {[false,true].sample}
    especie "MyString"
    data_nascimento Time.now
    raca "MyString"
    vivo true
  end
end
