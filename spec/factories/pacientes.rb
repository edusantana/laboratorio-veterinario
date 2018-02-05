FactoryBot.define do
  factory :paciente do
    nome "MyString"
    sexo {[false,true].sample}
    especie "MyString"
    data_nascimento "2018-02-01"
    raca "MyString"
    vivo true
  end
end
