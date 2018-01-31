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
    @user.has_role?(:dono, @org) || @user.has_role?(:tecnico, @org)  ||  @user.has_role?(:secretario, @org )
  end
end