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
      secretario? || tecnico? || dono?
    end

    def secretario?
      @user.has_role?(:secretario, @lab.organizacao)
    end

    def tecnico?
      @user.has_role?(:tecnico, @lab.organizacao)
    end

    def dono?
      @user.has_role?(:dono, @lab.organizacao)
    end

    def index_requisicoes?
      funcionario?
    end

  end

end