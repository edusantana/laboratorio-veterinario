require 'rails_helper'

RSpec.describe ExameTipoPolicy do

  subject { described_class.new(user, tipo) }

  let(:cliente){create(:user)}
  let(:secretario){User.with_role(:secretario, lab.organizacao).take}
  let(:tecnico){User.with_role(:tecnico, lab.organizacao).take}
  let(:dono){User.with_role(:dono, lab.organizacao).take}

  
  context "laboratório experimental" do
    let(:lab){create(:laboratorio_experimental)}
    let(:tipo){build(:exame_tipo, laboratorio: lab)}

    context "Usuário não logado" do
      let(:user){nil}
      it { is_expected.to permit_action(:update) }
      it { is_expected.to permit_action(:create) }
      it { is_expected.to permit_action(:destroy) }
    end

  end
  
  context "laboratório normal" do
    let(:lab){create(:laboratorio_com_funcionarios)}
    let(:tipo){build(:exame_tipo, laboratorio: lab)}

    context "Usuário não logado" do
      let(:user){nil}
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:create) }
    end

    context "Cliente" do
      let(:user){cliente}
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:create) }
    end

    context "Secretario" do
      let(:user){secretario}
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:create) }
    end

    context "Tecnico" do
      let(:user){tecnico}
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:create) }
    end

    context "Dono" do
      let(:user){dono}
      it { is_expected.to permit_action(:update) }
      it { is_expected.to permit_action(:create) }
    end


  end


  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
