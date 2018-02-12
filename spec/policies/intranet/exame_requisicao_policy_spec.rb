require 'rails_helper'

describe Intranet::ExameRequisicaoPolicy do
    
  subject { described_class.new(user, [:intranet, requisicao]) }


  let(:lab){create(:laboratorio_com_funcionarios)}
  let(:requisicao){create(:requisicao, laboratorio: lab)}
  let(:cliente){create(:user)}
  let(:secretario){User.with_role(:secretario, lab.organizacao).take}
  let(:tecnico){User.with_role(:tecnico, lab.organizacao).take}
  let(:dono){User.with_role(:dono, lab.organizacao).take}

  context 'sendo um cliente da organização do laboratório' do
    let(:user){cliente}
    it { is_expected.not_to permit_action(:confirmar_recebimento) }
    it { is_expected.not_to permit_action(:enviar_resultado) }
  end

  context 'sendo um secretário da organização do laboratório' do
    let(:user){secretario}
    it { is_expected.to permit_action(:confirmar_recebimento) }
    it { is_expected.not_to permit_action(:enviar_resultado) }
  end

  context 'sendo um tecnico da organização do laboratório' do
    let(:user){tecnico}
    it { is_expected.to permit_action(:confirmar_recebimento) }
    it { is_expected.to permit_action(:enviar_resultado) }
  end

  context 'sendo um dono da organização do laboratório' do
    let(:user){dono}
    it { is_expected.to permit_action(:confirmar_recebimento) }
    it { is_expected.to permit_action(:enviar_resultado) }
  end


end
