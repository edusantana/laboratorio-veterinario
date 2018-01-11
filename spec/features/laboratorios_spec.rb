require 'rails_helper'

RSpec.feature "Laboratorios", type: :feature do
  
  scenario "Acessando laboratório através do seu subdomínio" do
    dado_existe_um_laboratorio
    quando_acessar_subdominio_do_laboratorio
    entao_pagina_inicial_do_laboratorio_eh_exibida
  end

  scenario "Acessando laboratório inexistente" do
    pending "Apresentar erro e sugestão de laboratório ou navegação"
  end


  def dado_existe_um_laboratorio
    @lab = create(:laboratorio)
  end
  def quando_acessar_subdominio_do_laboratorio
    usando_labdomain(@lab)
    visit root_path
  end

  def entao_pagina_inicial_do_laboratorio_eh_exibida
    expect(page).to have_content(@lab.nome)
  end

end
