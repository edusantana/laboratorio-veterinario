# Support for Rspec / Capybara subdomain integration testing
# Make sure this file is required by spec_helper.rb
# (e.g. save as spec/support/subdomains.rb)
# https://gist.github.com/turadg/5399790


def usando_labdomain(lab)
  raise RuntimeError unless lab.organizacao.subdomain
  Capybara.app_host = "http://#{lab.organizacao.subdomain}.lvh.me"
end

def usando_subdomain(subdomain)
  # lvh.me always resolves to 127.0.0.1
  hostname = subdomain ? "#{subdomain}.lvh.me" : "lvh.me"
  Capybara.app_host = "http://#{hostname}"
end

def usando_main_domain
  usando_subdomain nil
end
 
RSpec.configure do |config|
  usando_main_domain
end

Capybara.configure do |config|
  config.always_include_port = true
end
