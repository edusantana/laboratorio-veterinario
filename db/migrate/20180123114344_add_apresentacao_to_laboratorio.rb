class AddApresentacaoToLaboratorio < ActiveRecord::Migration[5.1]
  def change
    add_column :laboratorios, :apresentacao, :string
  end
end
