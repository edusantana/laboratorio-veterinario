class AddEnderecoToUnidades < ActiveRecord::Migration[5.1]
  def change
    add_column :unidades, :endereco, :string
    add_column :unidades, :telefone, :string
  end
end
