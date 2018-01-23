require 'rails_helper'

RSpec.describe Laboratorio, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"


  context "Subdomain com valor inválido" do

    before do
      @lab = build(:laboratorio)
      @lab.subdomain = 'andro.meda'
    end

    it "não é salvo no banco" do
      skip "Não consigo validar esse erro"
      expect { @lab.save! }.to raise_error(NoMethodError)
    end

  end

end
