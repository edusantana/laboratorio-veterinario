# Support for Rspec / Capybara subdomain integration testing
# Make sure this file is required by spec_helper.rb
# (e.g. save as spec/support/subdomains.rb)
# https://gist.github.com/turadg/5399790


def usando_labdomain(lab)
  raise RuntimeError unless lab.organizacao.subdomain
  Capybara.app_host = "http://#{lab.organizacao.subdomain}.lvh.me"
  Capybara.default_host = Capybara.app_host
end

def usando_subdomain(subdomain)
  # lvh.me always resolves to 127.0.0.1
  hostname = subdomain ? "#{subdomain}.lvh.me" : "lvh.me"
  Capybara.app_host = "http://#{hostname}"
  Capybara.default_host = "http://#{hostname}"
end

def usando_main_domain
  usando_subdomain nil
end

def dado_estou_na_pagina_inicial_do_mundo_vet
  e_estou_na_pagina_inicial_do_mundo_vet
end
def e_estou_na_pagina_inicial_do_mundo_vet
  usando_main_domain
  visit root_path
end

def visit_clinica
  usando_subdomain(@clinica.organizacao.subdomain)
  visit root_path
end

RSpec.configure do |config|
  usando_main_domain
end
