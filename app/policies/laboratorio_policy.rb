class LaboratorioPolicy < ApplicationPolicy
  attr_reader :user, :lab

  def initialize(user, lab)
    @user = user
    @lab = lab
  end

  def show?
    funcionario?
  end
  
  def funcionario?
    @user.has_role?(:dono, @lab) || @user.has_role?(:tecnico, @lab)  ||  @user.has_role?(:secretario, @lab )
  end
end