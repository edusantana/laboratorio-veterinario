require 'spec_helper'

def login(user)
  visit root_path
  click_link 'Entrar'
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: "ruby123"
  click_on 'Login'  
end


def dado_um_veterinario_logado
  @veterinario = create(:veterinario)
  login(@veterinario)
end

def e_o_outro_cliente_logado
  dado_um_veterinario_logado
end

def e_um_veterinario_logado
  dado_um_veterinario_logado
end
