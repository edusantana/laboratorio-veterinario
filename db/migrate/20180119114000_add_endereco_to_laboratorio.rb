class AddEnderecoToLaboratorio < ActiveRecord::Migration[5.1]
  def change
    add_column :laboratorios, :endereco, :string
  end
end
