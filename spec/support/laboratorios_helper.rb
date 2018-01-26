# spec/support/laboratorio_helper.rb

def dado_um_laboratorio
  @lab = create(:laboratorio)
end
def dado_um_laboratorio_inexistente
  @lab = build(:laboratorio)
end

def dado_um_laboratorio_com_funcionarios
  @lab = create(:laboratorio_com_funcionarios)
  @dono = User.with_role(:dono, @lab).take
  @tecnico = User.with_role(:tecnico, @lab).take
  @secretario = User.with_role(:secretario, @lab).take
end

def dado_um_laboratorio_com_uma_unidade
  dado_um_laboratorio
  @unidade = create(:unidade, laboratorio: @lab)
  @lab.unidades << @unidade
end

def dado_um_laboratorio_com_alguns_tipos_de_exames_cadastrados
  dado_um_laboratorio
  @tipos = []
  @tipos << create(:exame_tipo, laboratorio: @lab)
end

def e_um_usuario_logado
  usando_labdomain(@lab)
  @user = create(:user)
  login(@user)
end

def e_um_tecnico_logado
  usando_labdomain(@lab)
  login(@tecnico)
end

def e_um_secretario_logado
  usando_labdomain(@lab)
  login(@secretario)
end

def e_o_outro_cliente_logado
  e_um_veterinario_logado
end

def e_um_veterinario_logado
  @veterinario = create(:veterinario)
  login(@veterinario)
end


# QUANDO  QUANDO  QUANDO  QUANDO  QUANDO 

def quando_acessar_subdominio_do_laboratorio
  usando_labdomain(@lab)
  visit root_path
end

def quando_acessar_pagina_inicial_do_laboratorio
  quando_acessar_subdominio_do_laboratorio
end

# CLICAR EM   CLICAR EM   CLICAR EM   CLICAR EM  

def e_clicar_em_intranet
  click_on("Intranet")
end
