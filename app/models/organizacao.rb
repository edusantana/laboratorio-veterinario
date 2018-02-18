class Organizacao < ApplicationRecord
  resourcify
  belongs_to :dono, class_name: "User", optional: true
  has_one :laboratorio
  has_one :clinica

  scope :experimental, -> { where(experimental: true) }
  scope :nao_experimental, -> { where(experimental: false) }


  def Organizacao.criar_clinica_demo

    org = Organizacao.where(subdomain: 'clinica').take

    if org
      org.clinica.destroy if org.clinica
      
      # destroy organizacao
      org.destroy
    end
    
    dono = User.where('email': 'dono@mundo.vet').take ||  User.create('email': 'dono@mundo.vet', nome: 'Dono', password: 'mundovet')
    dono.password = 'mundovet'
    dono.save
    org = Organizacao.create(subdomain: 'clinica', dono: dono)
    clinica = Clinica.create(organizacao: org, nome: "Clínica Demonstrativa")

    org
  end
  
end
