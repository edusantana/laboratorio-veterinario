class ExameRequisicaoPolicy < ApplicationPolicy
  attr_reader :user, :requisicao

  class Scope < Scope
    def resolve
      scope
    end
  end

  def initialize(user, requisicao)
    @user = user
    @requisicao = requisicao
  end

  def show?
    @requisicao.requisitante == @user
  end

  def update?
    @requisicao.requisitante == @user
  end

end
