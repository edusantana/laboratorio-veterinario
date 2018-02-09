require 'rails_helper'

RSpec.feature "Laboratorios", type: :feature do
  
  before(:each) do
    usando_main_domain
  end

  scenario "Acessando laboratório através do seu subdomínio" do
    dado_um_laboratorio
    quando_acessar_subdominio_do_laboratorio
    entao_pagina_inicial_do_laboratorio_eh_exibida
  end

  scenario "Acessando laboratório inexistente" do
    pending "Passará a ser domínio disponível"
    dado_um_laboratorio_inexistente
    quando_acessar_subdominio_do_laboratorio
    entao_pagina_de_laboratorio_inexistente_eh_exibida
  end

  scenario "Usuário não autorizado não tem permissão para acessar a intranet" do
    dado_um_laboratorio
    e_um_usuario_logado
    quando_acessar_a_intranet
    entao_pagina_inicial_do_laboratorio_eh_exibida
    e_estou_vendo_mensagem_que_nao_tenho_permissao_acessar_intranet
  end

  scenario "Técnico tem permissão para acessar a intranet" do
    dado_um_laboratorio_com_funcionarios
    e_um_tecnico_logado
    quando_acessar_a_intranet
    entao_estamos_na_intranet_do_laboratorio
  end

  scenario "Secretario tem permissão para acessar a intranet" do
    dado_um_laboratorio_com_funcionarios
    e_um_secretario_logado
    quando_acessar_a_intranet
    entao_estamos_na_intranet_do_laboratorio
  end

  feature "Logotipo" do

    scenario "O laboratório apresenta uma logo que corresponde ao gravatar do usuário dono" do
      dado_um_laboratorio_com_funcionarios
      quando_acessar_subdominio_do_laboratorio
      entao_estamos_estamos_vendo_o_logo_do_gravatar_do_dono
    end
      
  end

  feature "Unidades" do
    
    scenario "O nome, telefone e endereço das unidades são apresentadas no rodapé" do
      dado_um_laboratorio_com_uma_unidade
      quando_acessar_subdominio_do_laboratorio
      entao_nome_telefone_e_endereco_da_unidade_esta_no_rodape
    end
      
  end

  feature "Apresentação" do
    scenario "A página inicial do laboratório possui um texto de apresentação do laboratório" do
      dado_um_laboratorio
      quando_acessar_subdominio_do_laboratorio
      entao_pagina_inicial_do_laboratorio_eh_exibida
      e_estou_vendo_o_texto_de_apresentacao_do_laboratorio
    end

    scenario "A página inicial do laboratório mostra os exames disponíveis e o valor de cada um" do
      dado_um_laboratorio_com_alguns_tipos_de_exames_cadastrados
      quando_acessar_subdominio_do_laboratorio
      entao_pagina_inicial_do_laboratorio_eh_exibida
      e_estou_vendo_os_nomes_dos_exames_e_seus_valores
    end
  end

  def entao_pagina_inicial_do_laboratorio_eh_exibida
    expect(page).to have_content(@lab.nome)
  end

  def entao_pagina_de_laboratorio_inexistente_eh_exibida
    expect(page).to have_content("Laboratório inexistente")
    expect(page).to have_content(/O endereço que você está acessando \(http.+\) não pertence a nenhum laboratório cadastrado/)
  end

  def quando_acessar_a_intranet
    visit intranet_path
  end

  def e_estou_vendo_mensagem_que_nao_tenho_permissao_acessar_intranet
    expect(page).to have_content("Você não tem permissão para acessar a intranet deste laboratório.")
  end

  def entao_estamos_na_intranet_do_laboratorio
    expect(page).to have_current_path(intranet_path)
  end

  def entao_estamos_estamos_vendo_o_logo_do_gravatar_do_dono
    expect(page).to have_selector('#logo')
  end

  def entao_nome_telefone_e_endereco_da_unidade_esta_no_rodape
    expect(find("#rodade")).to have_content(@unidade.nome)
    expect(find("#rodade")).to have_content(@unidade.telefone)
    expect(find("#rodade")).to have_content(@unidade.endereco)    
  end

  def e_estou_vendo_o_texto_de_apresentacao_do_laboratorio
    expect(find("#apresentacao_inicial")).to have_content(@lab.apresentacao)
  end

  def e_estou_vendo_os_nomes_dos_exames_e_seus_valores
    @tipos.each do |tipo|
      expect(find("#tipos")).to have_content(tipo.nome)
      expect(find("#tipos")).to have_content(ActiveSupport::NumberHelper.number_to_currency(tipo.valor, unit: "R$", separator: ","))
    end
  end


end
