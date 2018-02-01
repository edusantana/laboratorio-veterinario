class Organizacao < ApplicationRecord
  resourcify
  belongs_to :dono, class_name: "User"
  has_one :laboratorio
  has_one :clinica

  def Organizacao.criar_clinica_demo

    org = Organizacao.where(subdomain: 'demo').take

    if org
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
