require 'rails_helper'

RSpec.feature "Atendimentos", type: :feature do
  
  background do
    dado_uma_clinica_demonstrativa_criada
    e_um_veterinario_da_clinica_logado
    dado_uma_familia_simples_cadastrada
    e_um_atendimento_ficticio
  end

  xscenario "Cadastrando um novo atendimento comum" do
    pending "Features de clínica foram potergadas"
    dado_estamos_na_pagina_novo_atendimento_paciente
    entao_estou_vendo_cabecalho_do_atendimento
    quando_preencher_a_anamnese
    e_clicar_em_salvar
    entao_estou_na_pagina_atendimento_edicao
    e_anamnese_foi_salva
    quando_eu_editar_as_demais_secoes_do_atendimento
    e_clicar_em_salvar
    entao_estou_na_pagina_atendimento_edicao
  end

  def entao_estou_vendo_cabecalho_do_atendimento
    expect(find('#cabecalho_atendimento')).to have_content(@paciente.nome)
    expect(find('#cabecalho_atendimento')).to have_content(@tutor.nome)
  end

  def e_um_atendimento_ficticio
    @atendimento = build(:atendimento)
  end

  def quando_preencher_a_anamnese
    fill_in('atendimento[anamnese]', with: @atendimento.anamnese)
  end

  def e_clicar_em_salvar
    click_on 'Salvar'
  end

  def entao_estou_na_pagina_atendimento_edicao
    expect(page).to have_current_path(/atendimentos\/.+\/edit/)
  end

  def quando_eu_editar_as_demais_secoes_do_atendimento
    fill_in('atendimento[anamnese]', with: @atendimento.anamnese + "\n Novo valor")

    fill_in 'atendimento[peso]', with: @atendimento.peso
    fill_in 'atendimento[temperatura_retal]', with: @atendimento.temperatura_retal
    fill_in 'atendimento[batimentos_cardiaco]', with: @atendimento.batimentos_cardiaco
    fill_in 'atendimento[frequencia_respiratoria]', with: @atendimento.frequencia_respiratoria

    fill_in 'atendimento[observacoes]', with: @atendimento.observacoes
    fill_in 'atendimento[achados_clinicos]', with: @atendimento.achados_clinicos

    fill_in 'atendimento[exames_complementares]', with: @atendimento.exames_complementares
    fill_in 'atendimento[diagnostico_presuntivo]', with: @atendimento.diagnostico_presuntivo
    fill_in 'atendimento[terapia_do_presuntivo]', with: @atendimento.terapia_do_presuntivo
    fill_in 'atendimento[diagnostico_definitivo]', with: @atendimento.diagnostico_definitivo
    fill_in 'atendimento[terapia_do_definitivo]', with: @atendimento.terapia_do_definitivo

  end

  def e_anamnese_foi_salva
    expect(find('#atendimento_anamnese').value).to eq(@atendimento.anamnese)
  end

end
