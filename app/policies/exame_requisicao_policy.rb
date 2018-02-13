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

  def create?
    true
  end

  def show?
    @requisicao.requisitante == @user
  end

  def update?
    #byebug
    @requisicao.requisitante == @user && @requisicao.aguardando_envio?
  end

end
