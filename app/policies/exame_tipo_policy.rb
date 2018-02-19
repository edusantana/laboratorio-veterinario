class ExameTipoPolicy < ApplicationPolicy

  def initialize(user, tipo)
    @user = user
    @tipo = tipo
    @org = tipo.laboratorio.organizacao
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    dono_ou_experimental
  end

  def update?
    dono_ou_experimental
  end

  def destroy?
    dono_ou_experimental
  end
  def edit_mode?
    dono_ou_experimental
  end
  def leave_edit?
    dono_ou_experimental
  end

  private
  def dono_ou_experimental
    @org.experimental? || @user && @user.has_role?(:dono, @org)
  end


end
