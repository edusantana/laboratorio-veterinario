# spec/support/exames_helper.rb

def e_uma_solicitacao_de_exame
  @exame_requisicao = create(:exame_requisicao, laboratorio: @lab)
end

def e_uma_solicitacao_de_exame_com_status_aguardando_resultado
  @exame_requisicao = create(:exame_requisicao_aguardando_resultado, laboratorio: @lab)
end

def e_uma_solicitacao_de_exame_com_resultado_disponivel
  @exame_requisicao = create(:exame_requisicao_com_resultado_disponivel, laboratorio: @lab)
end

def e_posso_ver_os_principais_dados_da_solicitacao
  expect(page).to have_content("Requisições de exames")
  expect(page).to have_content(@exame_requisicao.id)
  expect(page).to have_content(@exame_requisicao.proprietario)
  expect(page).to have_content(@exame_requisicao.nome)
  expect(page).to have_content(@exame_requisicao.created_at.strftime("%d/%m/%Y"))
  # FIXME incluir status
end

def e_estamos_vendo_o_status_resultado_disponivel
  expect(page).to have_content("Resultado disponível")
end

def e_posso_ver_link_para_baixar_o_resultado
  expect(find("#anexos")).to have_link("resultado-anexo1")
end

def e_posso_ver_o_status_aguardando_resultado
  expect(page).to have_content("Aguardando resultado")
end

