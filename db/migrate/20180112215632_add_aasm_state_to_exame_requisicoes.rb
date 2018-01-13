class AddAasmStateToExameRequisicoes < ActiveRecord::Migration[5.1]
  def change
    add_column :exame_requisicoes, :aasm_state, :string
  end
end
