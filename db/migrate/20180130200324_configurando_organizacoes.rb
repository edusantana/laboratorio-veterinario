class ConfigurandoOrganizacoes < ActiveRecord::Migration[5.1]
  def up
    Laboratorio.all.each do |lab|
      org = Organizacao.create
      lab.organizacao = org
      lab.save
    end
  end

  def down
    Laboratorio.all.each do |lab|      
      lab.organizacao.delete if lab.organizacao
      lab.organizacao = nil
      lab.save
    end
  end
    
end
