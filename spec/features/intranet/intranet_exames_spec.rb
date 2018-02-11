require 'rails_helper'

RSpec.feature "Intranet Exames", type: :feature do

  before(:each) do
    usando_main_domain
  end


  feature "Confirmando recebimento", :wip do
    
    context "de apenas uma requisição" do
      background do
        dado_um_laboratorio_com_funcionarios
        e_uma_solicitacao_de_exame
        e_o_secretario_estiver_logado
        quando_acessar_pagina_inicial_do_laboratorio
        e_clicar_em_intranet
        entao_estamos_na_intranet_do_laboratorio
      end
      scenario "Secretario do laboratório confirma recebimento de amostra de exame solicitado" do
        quando_clicar_em_solicitacoes_de_exames
        entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
        e_posso_ver_os_principais_dados_da_solicitacao
        quando_clicar_em_confirmar_recebimento_na_solicitacao
        entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
        e_o_status_da_solicitacao_mudou_para_aguardando_resultado
      end
    
      scenario "Secretario do laboratório confirma recebimento de amostra de exame solicitado (através de item confirmações)", js: true do
        # FIXME: update com patch
        # permace exibindo apenas nao recebidos
        quando_clicar_em_confirmar_recebimento_de_exames
        quando_clicar_em_confirmar_recebimento_na_solicitacao
        entao_estamos_na_pagina_intranet_recebimento_de_solicitacoes
        e_o_status_da_solicitacao_mudou_para_aguardando_resultado
      end
    end

    context "de várias requisições (geralmente chegada do motoboy)", :wip do
      background do
        dado_um_laboratorio_com_funcionarios
        e_varias_solicitacoes_de_exame
        e_o_secretario_estiver_logado
        quando_acessar_pagina_inicial_do_laboratorio
        e_clicar_em_intranet
        entao_estamos_na_intranet_do_laboratorio
      end

      scenario "confirmando recebimento de várias requisições sem atualizar a página", js: true do
        quando_clicar_em_confirmar_recebimento_de_exames
        entao_estamos_na_pagina_intranet_recebimento_de_solicitacoes
        quando_clicar_em_confirmar_recebimento_da_metade_das_solicitacoes
        entao_estamos_na_pagina_intranet_recebimento_de_solicitacoes
        e_a_metade_recebida_foi_marcada_como_recebida
        e_a_metade_nao_recebida_permanece_normal
      end
    end


  end


  scenario "Dono do laboratório ver dados da solicitação do exame para realizá-lo" do
    dado_um_laboratorio_com_funcionarios
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_dono_do_laboratorio_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_intranet
    entao_estamos_na_intranet_do_laboratorio
    quando_clicar_em_solicitacoes_de_exames
    entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    e_posso_ver_os_principais_dados_da_solicitacao
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
  end

  scenario "Tecnico do laboratório anexa resultado PDF de um exame" do
    dado_um_laboratorio_com_funcionarios
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_tecnico_do_laboratorio_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_intranet
    entao_estamos_na_intranet_do_laboratorio
    quando_clicar_em_solicitacoes_de_exames
    entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    e_posso_ver_os_principais_dados_da_solicitacao
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
    quando_anexar_um_documento_como_resultado
    e_clicar_em_anexar_ao_resultado
    entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
    e_estamos_vendo_o_status_resultado_disponivel
    e_posso_ver_link_para_baixar_o_resultado
  end

  scenario "Tecnico do laboratório anexa multiplas imagens a um exame" do
    dado_um_laboratorio_com_funcionarios
    e_uma_solicitacao_de_exame_com_status_aguardando_resultado
    e_o_tecnico_do_laboratorio_estiver_logado
    quando_acessar_pagina_inicial_do_laboratorio
    e_clicar_em_intranet
    entao_estamos_na_intranet_do_laboratorio
    quando_clicar_em_solicitacoes_de_exames
    entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    e_posso_ver_os_principais_dados_da_solicitacao
    quando_clicar_no_numero_do_protocolo
    entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
    quando_anexar_multiplas_imagens
    e_clicar_em_anexar_imagens
    entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
    #e_estamos_vendo_o_status_resultado_disponivel
    e_posso_ver_link_para_baixar_as_imagens
  end


  def e_o_tecnico_do_laboratorio_estiver_logado
    usando_labdomain(@lab)
    login(@tecnico)
  end

  def e_o_secretario_estiver_logado
    usando_labdomain(@lab)
    login(@secretario)
  end

  def e_o_dono_do_laboratorio_estiver_logado
    @dono = @lab.organizacao.dono
    usando_labdomain(@lab)
    login(@dono)
  end

  def entao_estamos_na_pagina_intranet_recebimento_de_solicitacoes
    expect(page).to have_current_path(confirmar_intranet_exame_requisicoes_path)
  end  

  def entao_estamos_na_intranet_do_laboratorio
    expect(page).to have_current_path(intranet_path)
  end

  def entao_estamos_na_intranet_de_lista_de_requisicoes_de_exames
    expect(page).to have_current_path(intranet_exame_requisicoes_path)
  end

  def entao_estamos_na_intranet_edicao_do_exame_vendo_os_detalhes_da_requisicao_de_exame
    expect(page).to have_current_path(edit_intranet_exame_requisicao_path(@exame_requisicao))
  end

  def quando_clicar_em_solicitacoes_de_exames
    click_on("Solicitações de exames")
  end

  def quando_anexar_um_documento_como_resultado
    #attach_file('exame_anexo[anexo][]', ["spec/samples/exame_anexos/exame-citopatologico1.pdf", 'spec/samples/exame_anexos/imagem-exame.jpg'])
    attach_file('exame_anexo[anexo]', "spec/samples/exame_anexos/exame-citopatologico1.pdf")
  end

  def quando_clicar_no_numero_do_protocolo
    click_on(@exame_requisicao.id)
  end

  def quando_anexar_multiplas_imagens
    attach_file('imagens[]', ['spec/samples/exame_imagens/exame-imagem1.jpg', 'spec/samples/exame_imagens/exame-imagem2.jpg'])
  end

  def e_clicar_em_anexar_ao_resultado
    click_on("Anexar ao resultado")
  end

  def e_clicar_em_anexar_imagens
    click_on("Anexar imagens")
  end

  def quando_clicar_em_confirmar_recebimento_de_exames
    click_on("Confirmar recebimentos de exames")
  end

  def quando_clicar_em_confirmar_recebimento_na_solicitacao
    click_on("confirmar_#{@exame_requisicao.id}")
    #find("#exame_requisicao#{@exame_requisicao.id}").find("#confirmar_recebimento").click
  end

  def quando_clicar_em_confirmar_recebimento_da_metade_das_solicitacoes
    @exame_requisicoes.each do |requisicao|
      next if requisicao.id.even?
      click_on("confirmar_#{requisicao.id}") # impares serão confirmados
    end
  end
  def e_a_metade_recebida_foi_marcada_como_recebida
    @exame_requisicoes.each do |requisicao|
      if requisicao.id.odd?
        expect(find("#status#{requisicao.id}")).to have_content("Aguardando resultado")
        expect(find("#acoes#{requisicao.id}")).to have_content("")
      end
    end
  end
  def e_a_metade_nao_recebida_permanece_normal
    @exame_requisicoes.each do |requisicao|
      if requisicao.id.even?
        expect(find("#status#{requisicao.id}")).to have_content("Aguardando envio da amostra")
        expect(find("#acoes#{requisicao.id}")).to have_content("Confirmar recebimento")
      end
    end
  end
  def e_o_status_da_solicitacao_mudou_para_aguardando_resultado
    expect(find("#status#{@exame_requisicao.id}")).to have_content("Aguardando resultado")
  end

  def e_posso_ver_link_para_baixar_as_imagens
    expect(find("#anexos")).to have_link("resultado-imagem1")
    expect(find("#anexos")).to have_link("resultado-imagem2")
  end



end