require 'rails_helper'

RSpec.feature "Exames", type: :feature do

  before(:example) do
    usando_main_domain
  end

  scenario "Veterinário solicitando um exame" do
    dado_existe_um_laboratorio
    e_dois_tipo_de_exames_cadastrados_no_laboratorio
    e_um_veterinario_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_solicitar_exame
    entao_estamos_na_pagina_de_requisicao_de_exame
    # e_vemos_um_link_instrucoes_para_solicitar_esse_exame
    quando_preencher_os_dados_da_requisicao_de_exame
    e_clicar_em_solicitar_exame
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    e_o_status_do_exame_aguardando_envio_da_coleta_eh_exibido
    e_instrucoes_para_entrega_da_coleta_eh_exibido
    #e_endereco_telefone_horario_recebimento_eh_exibido
  end

  scenario "Veterinário verificando status de exame requerido" do
    dado_existe_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_veterinario_que_solicitou_o_exame_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_resultados_dos_exames
    entao_estamos_na_pagina_de_lista_de_resultados
    e_posso_ver_os_principais_dados_da_solicitacao
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_pagina_de_vizualizacao_de_exame
    quando_clicar_em_voltar
    entao_estamos_na_pagina_de_lista_de_resultados
  end

  scenario "Dono do laboratório confirma recebimento de amostra de exame solicitado" do
    dado_existe_um_laboratorio
    e_uma_solicitacao_de_exame
    e_o_dono_do_laboratorio_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_intranet
    entao_estamos_na_intranet_do_laboratorio
    quando_clicar_em_solicitacoes_de_exames
    entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    e_posso_ver_os_principais_dados_da_solicitacao
    quando_clicar_em_confirmar_recebimento_na_solicitacao
    entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    e_o_status_da_solicitacao_mudou_para_aguardando_resultado
  end


  def dado_existe_um_laboratorio
    @lab = create(:laboratorio)
  end

  def e_uma_solicitacao_de_exame
    @exame_requisicao = create(:exame_requisicao, laboratorio: @lab)
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

  def e_um_veterinario_logado
    @veterinario = create(:veterinario)
    login(@veterinario)
  end

  def e_o_dono_do_laboratorio_estiver_logado
    @dono = @lab.dono
    login(@dono)
  end

  def quando_acessar_pagina_inicial_do_laboratorio
    usando_labdomain(@lab)
    visit root_path
  end

  def e_clicar_em_solicitar_exame
    click_on("Solicitar exame")
  end

  def e_clicar_em_resultados_dos_exames
    click_on("Resultados dos exames")
  end

  def e_clicar_em_intranet
    click_on("Intranet")
  end

  def entao_estamos_na_pagina_de_requisicao_de_exame
    expect(page).to have_current_path(new_exame_requisicao_path)
  end

  def entao_estamos_na_pagina_de_vizualizacao_de_exame
    # https://stackoverflow.com/questions/5228371/how-to-get-current-path-with-query-string-using-capybara
    expect(page).to have_current_path(/exame_requisicoes\/.+/)
  end

  def entao_estamos_na_intranet_do_laboratorio
    expect(page).to have_current_path(intranet_path)
  end

  def entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    expect(page).to have_current_path(intranet_exame_requisicoes_path)
  end

  def quando_preencher_os_dados_da_requisicao_de_exame
    observacoes = "Localização da lezão: Perna traseira direita\nDescrição da lezão: Corte profundo, não infecionado"
    @requisicao_dados = {"especie" => "Canino", "raca" => "Poodle", "idade" => 5, nome: "Lucas", "observacoes" => observacoes}
    @requisicao_dados.each {|k,v| fill_in("exame_requisicao_#{k}", with:v)}
  end

  def e_o_status_do_exame_aguardando_envio_da_coleta_eh_exibido
    expect(page).to have_content("Status")
    expect(page).to have_content("Aguardando envio da coleta")
  end

  def e_instrucoes_para_entrega_da_coleta_eh_exibido
    expect(page).to have_content("Instruções para entrega da coleta")
    expect(page).to have_content("Escreva no recipiente da coleta o número do protocolo e o nome do animal:")
    expect(page).to have_content(/\#[0-9]+ \- #{@requisicao_dados[:nome]}/)
  end

  def entao_estamos_na_pagina_de_lista_de_resultados
    expect(page).to have_current_path(exame_requisicoes_path)
  end

  def e_posso_ver_os_principais_dados_da_solicitacao
    expect(page).to have_content("Requisições de exames")
    expect(page).to have_content(@exame_requisicao.id)
    expect(page).to have_content(@exame_requisicao.proprietario)
    expect(page).to have_content(@exame_requisicao.nome)
    expect(page).to have_content(@exame_requisicao.created_at.strftime("%d/%m/%Y"))
    # FIXME incluir status
  end

  def e_o_status_da_solicitacao_mudou_para_aguardando_resultado
    expect(page).to have_content("Aguardando resultado")
  end

  def quando_clicar_no_numero_do_protocolo
    click_on(@exame_requisicao.id)
  end

  def quando_clicar_em_voltar
    click_on("Voltar")
  end

  def quando_clicar_em_solicitacoes_de_exames
    click_on("Solicitações de exames")
  end

  def quando_clicar_em_confirmar_recebimento_na_solicitacao
    #click_on( confirmar_recebimento")
    find("#exame_requisicao#{@exame_requisicao.id}").find("#confirmar_recebimento").click
  end


end
