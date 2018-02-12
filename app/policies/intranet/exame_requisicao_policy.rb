module Intranet

  class ExameRequisicaoPolicy < ApplicationPolicy
    attr_reader :user, :requisicao

    class Scope < Scope
      def resolve
        scope
      end
    end

    def initialize(user, requisicao)
      @user = user
      @requisicao = requisicao.last
    end

    def show?
      @requisicao.requisitante == @user
    end

    def update?
      secretario? || tecnico? || dono?
    end

    def confirmar_recebimento?
      secretario? || tecnico? || dono?
    end

    def enviar_resultado?
      tecnico? || dono?
    end

    private
    
    def secretario?
      @user.has_role?(:secretario, @requisicao.laboratorio.organizacao)
    end

    def tecnico?
      @user.has_role?(:tecnico, @requisicao.laboratorio.organizacao)
    end

    def dono?
      @user.has_role?(:dono, @requisicao.laboratorio.organizacao)
    end

  end

end