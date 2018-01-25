FactoryBot.define do
  
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :nome do |n|
    "nome-do-cliente#{n}"
  end
  
  sequence :crmv do |n|
    "crmv-#{n}"
  end
  
  sequence :telefone do |n|
    "XX-#{n}#{n}#{n}"
  end

  sequence :endereco do |n|
    "Meu-endereço-#{n}"
  end

  sequence :cpf do |n|
    "XXX-CPF-#{n}"
  end


  factory :user, aliases: [:veterinario, :requisitante] do
    email { generate(:email) }
    password "ruby123"
    nome { generate(:nome) }
    crmv { generate(:crmv) }
    telefone { generate(:telefone) }
    endereco { generate(:endereco) }
    cpf { generate(:cpf) }

    factory :veterinario_com_cadastro_incompleto do
      nome {nil}
      crmv {nil}
      cpf {nil}
      telefone {nil}
      endereco {nil}
    end
  end

end
