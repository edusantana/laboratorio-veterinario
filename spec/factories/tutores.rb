FactoryBot.define do
  factory :tutor do
    nome {"TutorNome-{rand}"}
    sexo false
    cpf {"CPF#{rand}"}
    email "MyString@mail.com"
    telefones "MyFoneString"
  end
end
