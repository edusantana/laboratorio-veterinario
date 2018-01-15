require 'spec_helper'

def login(user)
  visit root_path
  click_link 'Entrar'
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: "ruby123"
  click_on 'Login'  
end