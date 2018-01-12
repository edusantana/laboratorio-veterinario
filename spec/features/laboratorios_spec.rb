require 'rails_helper'

RSpec.feature "Laboratorios", type: :feature do
  
  scenario "Acessando laboratório através do seu subdomínio" do
    dado_existe_um_laboratorio
    quando_acessar_subdominio_do_laboratorio
    entao_pagina_inicial_do_laboratorio_eh_exibida
  end

  scenario "Acessando laboratório inexistente" do
    dado_um_laboratorio_existente
    quando_acessar_subdominio_do_laboratorio
    entao_pagina_de_laboratorio_inexistente_eh_exibida
  end


  def dado_existe_um_laboratorio
    @lab = create(:laboratorio)
  end

  def dado_um_laboratorio_existente
    @lab = build(:laboratorio)
  end

  def quando_acessar_subdominio_do_laboratorio
    usando_labdomain(@lab)
    visit root_path
  end

  def entao_pagina_inicial_do_laboratorio_eh_exibida
    expect(page).to have_content(@lab.nome)
  end

  def entao_pagina_de_laboratorio_inexistente_eh_exibida
    expect(page).to have_content("Laboratório inexistente")
    expect(page).to have_content(/O endereço que você está acessando \(http.+\) não pertence a nenhum laboratório cadastrado/)
  end


end
