module Intranet
  class LaboratorioPolicy < ApplicationPolicy
    attr_reader :user, :lab, :org

    def initialize(user, lab)
      @user = user
      @lab = lab.last # [:intranet, @lab]
      @org = @lab.organizacao
    end

    def show?
      funcionario?
    end
    
    def funcionario?
      experimental? || secretario? || tecnico? || dono?
    end

    def secretario?
      experimental? ||@user.has_role?(:secretario, @lab.organizacao)
    end

    def tecnico?
      experimental? ||@user.has_role?(:tecnico, @lab.organizacao)
    end

    def dono?
      experimental? ||@user.has_role?(:dono, @lab.organizacao)
    end

    def index_requisicoes?
      funcionario?
    end
    
    def experimental?
      @org.experimental?
    end

  end

end