require 'rails_helper'

RSpec.feature "Clinicas", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  feature "Todo veterinário possui acesso a uma clínica pessoal", :wip do
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

  def entao_estamos_na_pagina_da_clinica_pessoal
    expect(page).to have_current_path(clinica_path)
  end

  def e_clinica_pessoal_criada_com_exemplos
    
  end


end
