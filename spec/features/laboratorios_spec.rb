require 'rails_helper'

RSpec.feature "Laboratorios", type: :feature do
  
  before(:each) do
    usando_main_domain
  end

  context "Laboratório normal" do
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

  
  feature "Laboratório demonstrativo" do
    scenario "Concedendo permissão de técnico ao laboratório demonstrativo a qualquer usuário" do
      dado_um_laboratorio_demonstrativo
      e_um_usuario_logado_no_mundo_vet
      e_estou_na_pagina_inicial_do_mundo_vet
      quando_eu_clicar_em_conceder_permissoes_de_secretario_e_tecnico
      entao_estamos_na_intranet_do_laboratorio
    end
  end

  # Os laboratórios experimentais tem o propósito de
  # oferecerem uma experiencia agradável de experimentação
  feature "Laboratório experimental (em avaliacao)" do

    scenario "Criando laboratório, requisição e resultado", :wip do
      dado_estou_na_pagina_inicial_do_mundo_vet
      quando_eu_clicar_em_experimentar_um_laboratorio
      entao_estamos_na_pagina_de_criar_laboratorio
      quando_preencher_dados_para_criar_novo_laboratorio
      e_clicar_em_dados_complementares
      quando_preencher_os_dados_complementares
      e_clicar_em_criar_laboratorio
      entao_estamos_na_pagina_do_laboratorio
      e_podemos_ver_mensagem_esse_laboratorio_eh_experimental
      e_podemos_ver_os_dados_utilizados_na_criacao_do_laboratorio
    end

    scenario "Editando texto de apresentação", js: true do
      dado_um_laboratorio_experimental
      quando_acessar_subdominio_do_laboratorio
      e_clicar_em_editar_texto_de_apresentacao
      e_preencher_um_novo_texto_de_apresentacao
      e_clicar_em_atualizar_apresentacao
      entao_estamos_vendo_o_novo_texto_de_apresentacao
    end

  end

  feature "Criar e experimentar um laboratório", :fantasia do
    scenario "Criando laboratório, requisição e resultado", js: true do
      pending "falta implementar"
      quando_clicar_em_solicitar_exame
      entao_estamos_na_pagina_para_fazer_login
      quando_clicar_em_registra_se
      e_preencher_os_dados_do_usuario
      quando_clicar_em_registra_se
      entao_estamos_na_pagina_de_requisicao_de_exame
      quando_preencher_os_dados_da_requisicao_de_exame
      e_clicar_no_botao_solicitar_exame
      entao_estamos_na_pagina_de_vizualizacao_de_exame
      e_estou_lendo_que_os_funcionarios_trabalham_dentro_da_intranet
      quando_clicar_em_intranet
      entao_estamos_na_intranet_do_laboratorio      
      e_estou_lendo_que_esta_eh_uma_area_restrita_acesso_permintido_no_experimental
      quando_clicar_em_confirmar_recebimento_de_exames
      quando_clicar_em_confirmar_recebimento_na_solicitacao
      entao_estamos_na_pagina_intranet_recebimento_de_solicitacoes
      e_o_status_da_solicitacao_mudou_para_aguardando_resultado
      e_estou_lendo_os_resultados_dos_exames_sao_inseridos_pelos_tecnicos_em_outra_tela
      quando_eu_clicar_em_realizar_exames
      entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
      quando_anexar_um_documento_como_resultado
      e_clicar_em_anexar_ao_resultado
      entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
      e_estamos_vendo_o_status_resultado_disponivel
      e_posso_ver_link_para_baixar_o_resultado    
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

  def entao_estamos_na_pagina_de_criar_laboratorio
    expect(page).to have_current_path(new_laboratorio_path)
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

  def quando_eu_clicar_em_conceder_permissoes_de_secretario_e_tecnico
    click_on "Conceder permissões e acessar Intranet do laboratório demonstrativo"
  end

  def quando_eu_clicar_em_experimentar_um_laboratorio
    click_on "Criar um laboratório para experimentar"
  end

  def dado_um_laboratorio_demonstrativo
    @org = create(:organizacao, subdomain: 'labdemo')
    @lab = create(:laboratorio, organizacao: @org)
  end

  def quando_preencher_dados_para_criar_novo_laboratorio
    @org = build(:organizacao)
    @lab = build(:laboratorio, organizacao: @org)
    @unidade = build(:unidade, laboratorio: @lab)
    @exames = ""
    6.times {@exames << build(:exame_tipo).nome + "\n"}
        
    fill_in 'nome', with: @lab.nome
    fill_in 'subdomain', with: @org.subdomain
    fill_in 'unidade[telefone]', with: @unidade.telefone
    fill_in 'exames', with: @exames
  end
  
  def quando_preencher_os_dados_complementares
    fill_in 'unidade[nome]', with: @unidade.nome
    fill_in 'unidade[endereco]', with: @unidade.endereco
    fill_in 'apresentacao', with: @lab.apresentacao
  end

  def e_podemos_ver_os_dados_utilizados_na_criacao_do_laboratorio
    expect(page).to have_content @lab.nome
    expect(page).to have_content @unidade.telefone
    expect(page).to have_content @unidade.endereco
    expect(page).to have_content @unidade.nome
    @exames.each_line do |exame_nome|
      expect(page).to have_content exame_nome
    end
    expect(page).to have_content @lab.apresentacao
  end

  def e_clicar_em_criar_laboratorio
    click_on "criar_laboratorio"

  end
  
  def entao_estamos_na_pagina_do_laboratorio
    # expect(page).to have_current_path(root_url(subdomain: @org.subdomain))

    # necessário para correção do teste com subdomínio
    quando_acessar_subdominio_do_laboratorio
  end

  def e_podemos_ver_mensagem_esse_laboratorio_eh_experimental
    expect(page).to have_content("Este laboratório encontra-se no modo experimental")
    expect(page).to have_content("O modo experimental tem o propópsito de apresentar as funcionalidades do sistema e agiliar sua aquisição.")
    expect(page).to have_content("No modo experimental os acessos são irrestritos, qualquer usuário possui permissão total sobre o laboratório.")
  end

  def e_clicar_em_editar_texto_de_apresentacao
    click_on "edit_apresentacao"
  end

  def e_preencher_um_novo_texto_de_apresentacao
    @apresentacao = build(:laboratorio).apresentacao
    fill_in 'laboratorio[apresentacao]', with: @apresentacao
  end

  def e_clicar_em_atualizar_apresentacao
    click_on "atualizar_apresentacao"
  end

  def entao_estamos_vendo_o_novo_texto_de_apresentacao
    expect(find('#texto_de_apresentacao')).to have_content(@apresentacao)
  end

  def e_clicar_em_dados_complementares
    click_on "Dados complementares"
  end

end
