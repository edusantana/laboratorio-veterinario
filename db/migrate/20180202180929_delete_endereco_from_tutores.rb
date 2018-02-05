class DeleteEnderecoFromTutores < ActiveRecord::Migration[5.1]
  def change
    remove_reference :tutores, :endereco, foreign_key: {to_table: :enderecos}
  end
end
