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
      lab.org.delete if lab.org
      lab.org = nil
      lab.save
    end
  end
    
end
