require 'spec_helper'

def login(user)
  visit root_path
  click_link 'Entrar'
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_on 'Login'  
end