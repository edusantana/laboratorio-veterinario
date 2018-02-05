class CreateEnderecos < ActiveRecord::Migration[5.1]
  def change
    create_table :enderecos do |t|
      t.string :cidade
      t.string :endereco
      t.string :numero
      t.string :complemento
      t.string :estado

      t.timestamps
    end
  end
end
