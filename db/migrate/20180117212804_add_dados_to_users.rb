class AddDadosToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nome, :string
    add_column :users, :cpf, :string
    add_column :users, :crmv, :string
    add_column :users, :telefone, :string
    add_column :users, :endereco, :text
  end
end
