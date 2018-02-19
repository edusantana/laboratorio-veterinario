require 'rails_helper'

RSpec.feature "Exames", type: :feature do

  before(:each) do
    usando_main_domain
  end

  scenario "Veterinário solicitando um exame" do
    dado_um_laboratorio
    e_dois_tipo_de_exames_cadastrados_no_laboratorio
    e_um_veterinario_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_solicitar_exame
    entao_estamos_na_pagina_de_requisicao_de_exame
    # e_vemos_um_link_instrucoes_para_solicitar_esse_exame
    quando_preencher_os_dados_da_requisicao_de_exame
    e_clicar_no_botao_solicitar_exame
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_o_status_do_exame_aguardando_envio_da_amostra_eh_exibido
    #e_instrucoes_para_entrega_da_amostra_eh_exibido
    #e_endereco_telefone_horario_recebimento_eh_exibido
  end

  scenario "Veterinário solicitando exame com base nos dados de outra requisição" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_uma_requisicao_de_exame
    entao_estamos_vendo_um_botao_solicitar_novo_exame
    quando_clicar_no_botao_solicitar_novo_exame_semelhante
    entao_estamos_na_pagina_de_novo_exame_semelhante
    e_o_formulario_esta_preenchido_com_os_dados_da_solicitacao_anterior
  end

  scenario "Veterinário verificando status de exame requerido" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_resultados
    entao_estamos_na_pagina_de_lista_de_resultados
    e_posso_ver_os_principais_dados_da_solicitacao
    e_posso_ver_o_status_aguardando_envio
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_nao_ha_resultados_exibidos
    quando_clicar_em_voltar
    entao_estamos_na_pagina_de_lista_de_resultados
  end

  scenario "Veterinário baixando o resultado" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame_com_resultado_disponivel
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_resultados
    entao_estamos_na_pagina_de_lista_de_resultados
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_estamos_vendo_o_status_resultado_disponivel
    e_posso_ver_link_para_baixar_o_resultado
  end

  scenario "Veterinário verificando status de exame após recebido pelo laboratório" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_resultados
    entao_estamos_na_pagina_de_lista_de_resultados
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_posso_ver_o_status_aguardando_resultado
  end


  scenario "Cliente não consegue editar exame após recebido pelo laboratório" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_tentar_editar_o_exame
    entao_vemos_uma_mensagem_que_nao_temos_permissao_para_editar_o_exame
  end

  scenario "Veterinário com cadastro incompleto não consegue solicitar exames" do
    dado_um_laboratorio
    e_um_veterinario_com_cadastro_incompleto_logado
    quando_tentar_criar_um_novo_exame
    entao_fui_redirecionado_para_pagina_de_edicao_de_perfil
    e_estamos_vendo_uma_mensagem_que_nao_eh_possivel_solicitar_exames_com_cadastro_incompleto
  end

  scenario "Cliente verificando resultado do exame anexado" do
    dado_um_laboratorio_com_funcionarios
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_resultados
    entao_estamos_na_pagina_de_lista_de_resultados
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_posso_ver_o_status_aguardando_resultado
  end

  scenario "Cliente não tem acesso a verificar o exame de outro cliente" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_outro_cliente_logado
    quando_tentar_acessar_o_exame
    entao_vemos_uma_mensagem_que_nao_temos_permissao_para_acessar_o_exame
  end

  scenario "Cliente não tem acesso para editar o exame de outro cliente" do
    dado_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_outro_cliente_logado
    quando_tentar_editar_o_exame
    entao_vemos_uma_mensagem_que_nao_temos_permissao_para_editar_o_exame
  end

  feature "Gerenciando tipos de exame" do

    context "em laboratório experimental" do
      background do
        dado_um_laboratorio_experimental
      end
      
      scenario "sem tipos de exames cadastrados e adicionando novo tipo", exame_tipos:true, js: true do
        dado_um_tipo_de_exame_que_desejo_cadastrar
        quando_acessar_pagina_inicial_do_laboratorio
        entao_lemos_que_nenhum_tipo_de_exame_foi_cadastrado
        e_o_botao_solicitar_novo_exame_esta_desabilitado
        e_lemos_que_o_primeiro_passo_eh_cadastrar_tipos_de_exames
        quando_preencher_nome_e_valor_do_tipo_de_exame
        e_clicar_em_adicionar_tipo_de_exame
        entao_o_novo_tipo_de_exame_foi_adicionado_a_tabela_de_tipos       
      end

      scenario "removendo tipo de exame cadastrado (sem exames realizados)", wip:true, js: true do
        dado_um_tipo_de_exame
        quando_acessar_pagina_inicial_do_laboratorio
        entao_estamos_vendo_o_tipo_de_exame_e_botoes_de_acoes
        quando_clicar_no_botao_remover_o_tipo_de_exame
        entao_o_tipo_de_exame_foi_removido
      end

    end
  end
  
  def e_o_veterinario_que_solicitou_o_exame_estiver_logado
    @veterinario = @exame_requisicao.requisitante
    usando_labdomain(@lab)
    login(@exame_requisicao.requisitante)
  end

  def e_dois_tipo_de_exames_cadastrados_no_laboratorio
    @campos = "Localização da lezão, Descrição da lezão"
    @tipo1 = create(:exame_tipo, nome: 'Citopatológico', laboratorio: @lab, campos: @campos)
    @tipo2 = create(:exame_tipo, laboratorio: @lab)
    @tipos = [@tipo1, @tipo2]
  end

  def e_um_veterinario_com_cadastro_incompleto_logado
    @veterinario = create(:veterinario_com_cadastro_incompleto)
    login(@veterinario)
  end

  def quando_tentar_editar_o_exame
    usando_labdomain(@lab)
    visit edit_exame_requisicao_path(@exame_requisicao)    
  end  

  def quando_tentar_acessar_o_exame
    usando_labdomain(@lab)
    visit exame_requisicao_path(@exame_requisicao)
  end

  def quando_acessar_uma_requisicao_de_exame
    quando_tentar_acessar_o_exame
  end

  def quando_tentar_criar_um_novo_exame
    usando_labdomain(@lab)
    visit new_exame_requisicao_path
  end

  
  def e_clicar_em_solicitar_exame
    click_on("Solicitar exame")
  end

  def e_clicar_em_resultados
    find('header').click_on("Resultados")
  end

  def e_clicar_no_botao_solicitar_exame
    click_button('Solicitar exame')
  end

  def entao_estamos_na_pagina_de_requisicao_de_exame
    expect(page).to have_current_path(new_exame_requisicao_path)
  end

  def entao_estamos_na_pagina_de_vizualizacao_de_exame
    # https://stackoverflow.com/questions/5228371/how-to-get-current-path-with-query-string-using-capybara
    expect(page).to have_current_path(/exame_requisicoes\/.+/)
  end

  def entao_estamos_na_pagina_de_lista_de_resultados
    expect(page).to have_current_path(exame_requisicoes_path)
  end


  def entao_estamos_na_pagina_de_novo_exame_semelhante
    expect(page).to have_current_path(novo_semelhante_exame_requisicao_path(@exame_requisicao))
  end

  def entao_fui_redirecionado_para_pagina_de_edicao_de_perfil
    expect(page).to have_current_path(edit_user_registration_path)
    
  end

  def quando_preencher_os_dados_da_requisicao_de_exame
    observacoes = "Localização da lezão: Perna traseira direita\nDescrição da lezão: Corte profundo, não infecionado"
    @requisicao_dados = {"especie" => "Canino", "raca" => "Poodle", "idade" => 5, nome: "Lucas", 'suspeita_clinica' => "Acho que é dengue", "observacoes" => observacoes}
    @requisicao_dados.each {|k,v| fill_in("exame_requisicao_#{k}", with:v)}
  end

  def e_nao_ha_resultados_exibidos
    expect(find('main')).not_to have_content("Resultado")
  end

  def e_o_status_do_exame_aguardando_envio_da_amostra_eh_exibido
    expect(page).to have_content("Status")
    expect(page).to have_content("Aguardando envio da amostra")
  end

  def e_instrucoes_para_entrega_da_amostra_eh_exibido
    expect(page).to have_content("Instruções para entrega da amostra")
    expect(page).to have_content("Escreva no recipiente da amostra o número do protocolo e o nome do animal:")
    expect(page).to have_content(/\#[0-9]+ \- #{@requisicao_dados[:nome]}/)
  end

  def e_posso_ver_o_status_aguardando_envio
    expect(page).to have_content("Aguardando envio da amostra")
  end

  def quando_clicar_no_numero_do_protocolo
    click_on(@exame_requisicao.id)
  end

  def quando_clicar_em_voltar
    click_on("Voltar")
  end

  def quando_clicar_em_inserir_resultado
    click_on("Inserir resultado")
  end

  def quando_clicar_no_botao_solicitar_novo_exame_semelhante
    click_on("Novo exame semelhante")
  end

  def entao_vemos_uma_mensagem_que_nao_temos_permissao_para_acessar_o_exame
    expect(page).to have_content("Você não em permissão para acessar este exame.")    
  end

  def entao_vemos_uma_mensagem_que_nao_temos_permissao_para_editar_o_exame
    expect(page).to have_content("Não é possível editar um exame após o recebimento ser confirmado.")    
  end

  def e_estamos_vendo_uma_mensagem_que_nao_eh_possivel_solicitar_exames_com_cadastro_incompleto
    expect(page).to have_content("Atualize o perfil completo para poder solicitar exames.")
  end

  def e_vemos_um_link_para_acessar_o_resultado_anexado
    find("#anexos").find("a").click
  end

  def e_vendo_dois_links_baixar_os_arquivos_enviados
    expect(find("#anexos")).to have_link("resultado-anexo1")
  end

  def entao_estamos_vendo_um_botao_solicitar_novo_exame
    expect(find("main")).to have_link("novo_semelhante")
  end

  def e_o_formulario_esta_preenchido_com_os_dados_da_solicitacao_anterior
    #expect(page).to have_field('#exame_requisicao_proprietario', with: @exame_requisicao.proprietario)
    skip "Está funcionando, mas falta implementar teste de verificação"
  end

  def entao_lemos_que_nenhum_tipo_de_exame_foi_cadastrado
    expect(page).to have_content("Nenhum tipo de exame foi cadastrado.")
    # Ainda falta cadastrar os tipos de exames que esse laboratório irá oferecer para seus clientes.
  end

  def e_o_botao_solicitar_novo_exame_esta_desabilitado
    #expect(find('#botao_solicitar_exame').enable).to eq(false)
    find('#botao_solicitar_exame'){|e| e['class'].include?('disabled')}
  end

  def e_lemos_que_o_primeiro_passo_eh_cadastrar_tipos_de_exames
    expect(find('#passos')).to have_content("Adicione os tipos de exames que seu laboratório realiza")
  end

  def dado_um_tipo_de_exame_que_desejo_cadastrar
    @exame_tipo = build(:exame_tipo, laboratorio: @lab)
  end

  def quando_preencher_nome_e_valor_do_tipo_de_exame
    fill_in 'exame_tipo[nome]', with: @exame_tipo.nome
    fill_in 'exame_tipo[valor]', with: @exame_tipo.valor
  end

  def e_clicar_em_adicionar_tipo_de_exame
    click_on 'adicionar_tipo'
  end

  def entao_o_novo_tipo_de_exame_foi_adicionado_a_tabela_de_tipos
    expect(find("#tipos")).to have_content(@exame_tipo.nome)
  end

  def entao_o_tipo_de_exame_foi_removido
    expect(find("#tipos")).not_to have_content(@exame_tipo.nome)
  end

  def entao_estamos_vendo_o_tipo_de_exame_e_botoes_de_acoes
    expect(find("#tipos")).to have_content(@exame_tipo.nome)

    expect(find('#tipos')).to have_button("edit_exame_tipo_#{@exame_tipo.id}")
    expect(find('#tipos')).to have_button("delete_exame_tipo_#{@exame_tipo.id}")

  end

  def quando_clicar_no_botao_remover_o_tipo_de_exame
    click_on "delete_exame_tipo_#{@exame_tipo.id}"
  end

end
