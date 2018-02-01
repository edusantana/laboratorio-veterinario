class AddOrganizacaoIdToClinicas < ActiveRecord::Migration[5.1]
  def change
    add_reference :clinicas, :organizacao, foreign_key: {to_table: :organizacoes}
  end
end
