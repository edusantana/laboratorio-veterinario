require 'rails_helper'

describe ExameRequisicaoPolicy do
    
  subject { described_class.new(user, requisicao) }


  let(:lab){create(:laboratorio_com_funcionarios)}
  let(:requisicao){create(:requisicao, laboratorio: lab)}
  let(:cliente){create(:user)}
  let(:requisitante){requisicao.requisitante}

  context 'sendo um cliente da organização do laboratório' do
    let(:user){cliente}
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    context "tentando atualizar requisição de outro cliente" do
      it { is_expected.not_to permit_action(:update) }
    end
  end

  context 'sendo o requisitante da requisição' do
    let(:user){requisitante}
    it { is_expected.to permit_action(:update) }

    context "requisição já foi recebida" do
      let(:requisicao){create(:exame_requisicao_aguardando_resultado, laboratorio: lab)}
      it { is_expected.not_to permit_action(:update) }
    end

  end

end
