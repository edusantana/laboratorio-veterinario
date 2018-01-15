require 'rails_helper'

RSpec.feature "Laboratorios", type: :feature do
  
  before(:each) do
    usando_main_domain
  end

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

  scenario "Usuário não autorizado não tem permissão para acessar a intranet", :wip do
    dado_um_laboratorio_existente
    e_um_usuario_logado
    quando_acessar_a_intranet
    entao_pagina_inicial_do_laboratorio_eh_exibida
    e_estou_vendo_mensagem_que_nao_tenho_permissao_acessar_intranet
  end

  def dado_existe_um_laboratorio
    @lab = create(:laboratorio)
  end

  def dado_um_laboratorio_existente
    @lab = create(:laboratorio)
  end

  def e_um_usuario_logado
    usando_labdomain(@lab)
    @user = create(:user)
    login(@user)
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

  def quando_acessar_a_intranet
    visit intranet_path
  end

  def e_estou_vendo_mensagem_que_nao_tenho_permissao_acessar_intranet
    expect(page).to have_content("Você não tem permissão para acessar a intranet deste laboratório.")
  end

end
