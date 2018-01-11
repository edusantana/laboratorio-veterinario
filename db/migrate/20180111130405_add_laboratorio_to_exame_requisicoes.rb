class AddLaboratorioToExameRequisicoes < ActiveRecord::Migration[5.1]
  def change
    add_reference :exame_requisicoes, :laboratorio, foreign_key: true, null: false
  end
end
