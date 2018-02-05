require 'rails_helper'

RSpec.feature "Clinicas", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  feature "O cadastro do paciente e tutor é realizado em conjunto no início do atendimento", :wip do
  
    background do
      dado_uma_clinica_demonstrativa_criada
      e_um_veterinario_da_clinica_logado
    end
    
    scenario "Cadastrando nova família (um paciente e um tutor)" do
      e_uma_familia_simples_que_desejamos_cadastrar
      e_estamos_na_pagina_da_clinica_demo      
      quando_clicamos_em_cadastrar_nova_familia
      entao_vamos_para_pagina_de_cadastro_de_nova_familia
      quando_preencho_os_dados_do_tutor
      e_clicamos_em_adicionar_tutor
      entao_permanecemos_na_pagina_de_cadastro_da_familia
      e_vemos_que_o_tutor_foi_cadastrado
      quando_preencho_os_dados_do_paciente
      e_clicamos_em_adicionar_paciente
      entao_permanecemos_na_pagina_de_cadastro_da_familia
      e_vemos_que_o_paciente_foi_cadastrado
    end

    scenario "Cadastrando nova família (múltiplos pacientes e tutores)" do
      e_uma_familia_composta_que_desejamos_cadastrar
      e_estamos_na_pagina_da_clinica_demo      
      quando_clicamos_em_cadastrar_nova_familia
      entao_vamos_para_pagina_de_cadastro_de_nova_familia
      quando_preencho_os_dados_de_cada_tutor_e_clicamos_em_adicionar_tutor
      entao_permanecemos_na_pagina_de_cadastro_da_familia
      e_vemos_que_os_tutores_foram_cadastrado
      quando_preencho_os_dados_dos_pacientes_e_clicamos_em_adicionar_paciente
      entao_permanecemos_na_pagina_de_cadastro_da_familia
      e_vemos_que_os_pacientes_foram_cadastrados
    end
    
  end

  feature "O sistema possui uma clínica demonstrativa", :wipo do
    scenario "que pode ser criada através de um link na página inicial" do
      dado_um_veterinario_logado
      quando_clicar_em_criar_clinica_demo
      entao_estamos_na_pagina_da_clinica_demo
      e_estamos_vendo_msg_clinica_demonstrativa_foi_reiniciada
      e_estamos_vendo_pagina_da_clinica
      e_estamos_vendo_o_layout_da_pagina_de_clinica
    end
    scenario "que pode ser recriada através de um link na página inicial" do
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

  feature "Clínica demonstrativa iniciada com alguns cadastros para facilitar aprendizagem do uso" do

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

  def dado_uma_clinica_demonstrativa_criada
    @org = Organizacao.criar_clinica_demo
    @clinica = @org.clinica
  end

  def e_um_paciente_canino_que_desejamos_cadastrar
    @paciente = build(:paciente, especie: 'canina')
  end

  def e_um_tutor_que_desejamos_cadastrar
    @tutor = build(:tutor)
  end

  def e_estamos_na_pagina_da_clinica_demo
    visit_clinica
  end

  def e_um_veterinario_da_clinica_logado
    @veterinario = create(:user)
    @veterinario.add_role(:veterinario, @clinica.organizacao)
    login(@veterinario)
  end

  def e_uma_familia_simples_que_desejamos_cadastrar
    @familia = build(:familia_simples, clinica: @clinica)
    @tutor = @familia.tutores.first
    @paciente = @familia.pacientes.first
  end

  def e_uma_familia_composta_que_desejamos_cadastrar
    @familia = build(:familia_composta, clinica: @clinica)
    @tutores = @familia.tutores
    @pacientes = @familia.pacientes
  end

  def quando_clicamos_iniciar_atendimento
    click_on("Iniciar atendimento")
  end

  def e_clicamos_em_adicionar_tutor
    click_on("Adicionar tutor")
  end

  def e_clicamos_em_adicionar_paciente
    click_on("Adicionar paciente")
  end

  def quando_clicamos_em_cadastrar_nova_familia
    click_on("#cadastrar_nova_familia")
  end

  def entao_vamos_para_pagina_inicial_de_atendimento
    expect(page).to have_current_path(iniciando_atendimento_path)
  end

  def entao_vamos_para_pagina_de_cadastro_de_nova_familia
    expect(page).to have_content("Cadastrando família (tutores e pacientes)")
  end

  def entao_permanecemos_na_pagina_de_cadastro_da_familia
    entao_vamos_para_pagina_de_cadastro_de_nova_familia
  end

  def quando_preencho_os_dados_de_cada_tutor_e_clicamos_em_adicionar_tutor
    @familia.tutores.each do |t|
      @tutor = t
      quando_preencho_os_dados_do_tutor
      e_clicamos_em_adicionar_tutor
    end
  end

  def quando_preencho_os_dados_do_tutor
    fill_in('tutor[nome]', with: @tutor.nome)
    fill_in('tutor[email]', with: @tutor.email)
    fill_in('tutor[cpf]', with: @tutor.cpf)
    fill_in('tutor[telefones]', with: @tutor.telefones)
  end
  
  def e_vemos_que_o_tutor_foi_cadastrado
    expect(find('#tutores_cadastrados')).to have_content(@tutor.nome)
  end

  def e_vemos_que_os_tutores_foram_cadastrado
    @familia.tutores.each do |t|
      @tutor = t
      e_vemos_que_o_tutor_foi_cadastrado
    end
  end

  def e_vemos_que_o_paciente_foi_cadastrado
    expect(find('#pacientes_cadastrados')).to have_content(@paciente.nome)
  end

  def e_vemos_que_os_pacientes_foram_cadastrados
    @familia.pacientes.each do |p|
      @paciente = p
      e_vemos_que_o_paciente_foi_cadastrado
    end
  end

  def quando_preencho_os_dados_dos_pacientes_e_clicamos_em_adicionar_paciente
    @familia.pacientes.each do |p|
      @paciente = p
      quando_preencho_os_dados_do_paciente
      e_clicamos_em_adicionar_paciente
    end
  end

  def quando_preencho_os_dados_do_paciente
    fill_in('paciente[nome]', with: @paciente.nome)
    if @paciente.sexo 
      choose('paciente_sexo_feminino') 
    else 
      choose('paciente_sexo_feminino') 
    end
    fill_in('paciente[especie]', with: @paciente.especie)
    fill_in('paciente[raca]', with: @paciente.raca)
    fill_in('paciente[data_nascimento]', with: @paciente.data_nascimento)
  end

#       e_um_paciente_canino_que_desejamos_cadastrar
# e_um_tutor_que_desejamos_cadastrar


end
