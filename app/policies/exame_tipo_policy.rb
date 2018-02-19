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
    @org.experimental? || @user && @user.has_role?(:dono, @org)
  end

  def update?
    @org.experimental? || @user && @user.has_role?(:dono, @org)
  end


end
