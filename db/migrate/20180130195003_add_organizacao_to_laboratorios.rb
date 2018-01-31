class AddOrganizacaoToLaboratorios < ActiveRecord::Migration[5.1]
  def change
    add_reference :laboratorios, :organizacao, foreign_key: {to_table: :organizacoes}
  end
end
