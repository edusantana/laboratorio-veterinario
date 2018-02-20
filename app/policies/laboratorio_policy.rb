class LaboratorioPolicy < ApplicationPolicy
  attr_reader :user, :lab, :org

  def initialize(user, lab)
    @user = user
    @lab = lab
    @org = lab.organizacao
  end

  def show?
    funcionario?
  end
  
  def funcionario?
    experimental? || @user.has_role?(:dono, @org) || @user.has_role?(:tecnico, @org)  ||  @user.has_role?(:secretario, @org )
  end

  def listar_requisicoes?
    true # qualquer um pode listar os seus exames em um laboratório
  end

  def update?
    experimental? || @user && @user.has_role?(:dono, @org)
  end

  def experimental?
    @org.experimental?
  end

end