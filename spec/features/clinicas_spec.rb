require 'rails_helper'

RSpec.feature "Clinicas", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  feature "O sistema possui uma clínica demonstrativa", :wip do
    scenario "Usuário pode criar a clínica demonstrativa através de um link" do
      dado_um_veterinario_logado
      quando_clicar_em_criar_clinica_demo
      entao_estamos_na_pagina_da_clinica_demo
      e_estamos_vendo_msg_clinica_demonstrativa_foi_reiniciada
      e_estamos_vendo_pagina_da_clinica
      e_estamos_vendo_o_layout_da_pagina_de_clinica
    end
    scenario "Usuário pode recriar a clínica demonstrativa através de um link" do
      dado_um_veterinario_logado
      e_uma_clinica_demonstrativa_criada
      quando_clicar_em_criar_clinica_demo
      entao_estamos_na_pagina_da_clinica_demo
      e_estamos_vendo_msg_clinica_demonstrativa_foi_reiniciada
      e_estamos_vendo_pagina_da_clinica
      e_estamos_vendo_o_layout_da_pagina_de_clinica
    end

  end

  feature "Todo veterinário possui acesso a uma clínica pessoal" do
    scenario "Usuário recém criado acessa clínica pessoal em /clinica" do
      dado_um_veterinario_logado
      quando_clicar_em_minha_clinica
      entao_estamos_na_pagina_da_clinica_pessoal
    end
  end

  feature "Clínica é iniciada com alguns cadastros para facilitar aprendizagem do uso" do

    pending "Bidu/Mônica"
    pending "Marley/Cachorro/John e Jenny Grogan"
    pending "Pluto/Caninca,bloodhound/Mickey"
    pending "Garfield/Gato/Jon"
    pending 'Frajola/Gato/Vovó'
    pending "Cavalo de fogo/Cavalo/Princesa Sara"
    pending "Secretariat/Cavalo/Penny Chenery"
    pending 'Piu Piu/Ave/Vovó'
    pending "Alvin/Roedores/Dave Seville"
    pending 'Pequeno Stuart Little/Mr. Little'

  end

  feature "Aprendendo iniciar consulta de animal já cadastrado" do
    
    background do
      dado_um_veterinario_logado
      e_clinica_pessoal_criada_com_exemplos
      quando_clicar_em_minha_clinica
      entao_estamos_na_pagina_da_clinica_pessoal
    end
  
    scenario "Iniciando consulta pesquisando pelo nome do paciente" do
      quando_preencher_painel_de_pesquisa_com_Bidu
      e_clicar_em_pesquisar
      entao_estamos_na_pagina_de_resultados_de_pesquisa
      e_podemos_ver_o_resultado_bidu_especie_raca_tutor
      quando_clicamos_no_resultado_bidu
      entao_vamos_para_pagina_do_paciente
    end
  end

  def quando_clicar_em_minha_clinica
    click_on("Minha clínica")
  end

  def quando_clicar_em_criar_clinica_demo
    click_on("criar_clinica_demo")
  end

  def entao_estamos_na_pagina_da_clinica_demo
    expect(page).to have_current_path(root_path)
  end

  def e_estamos_vendo_msg_clinica_demonstrativa_foi_reiniciada
    expect(page).to have_content("Clínica demonstrativa foi recriada.")
  end

  def e_estamos_vendo_pagina_da_clinica
    expect(page).to have_content("Clínica Demonstrativa")
  end

  def e_estamos_vendo_o_layout_da_pagina_de_clinica
    expect(page).to have_content("Layout clínica")
  end

  def e_uma_clinica_demonstrativa_criada
    @demo = Organizacao.criar_clinica_demo
  end

end
