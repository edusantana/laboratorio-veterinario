# spec/support/clinicas_helper.rb

def dado_uma_clinica_demonstrativa_criada
  @org = Organizacao.criar_clinica_demo
  @clinica = @org.clinica
end

def e_um_veterinario_da_clinica_logado
  @veterinario = create(:user)
  @veterinario.add_role(:veterinario, @clinica.organizacao)
  login(@veterinario)
end

def dado_uma_familia_simples_cadastrada
  @familia = create(:familia_simples, clinica: @clinica)
  @tutor = @familia.tutores.first
  @paciente = @familia.pacientes.first
end

def e_estamos_na_pagina_da_clinica_demo
  visit_clinica
end

def e_estamos_na_pagina_de_edicao_da_familia
  visit_clinica
  visit edit_familia_path(@familia)
end

def dado_estamos_na_pagina_novo_atendimento_paciente
  visit_clinica
  visit new_paciente_atendimento_path(@paciente)
end
