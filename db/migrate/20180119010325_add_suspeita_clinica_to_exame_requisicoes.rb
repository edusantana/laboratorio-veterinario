class AddSuspeitaClinicaToExameRequisicoes < ActiveRecord::Migration[5.1]
  def change
    add_column :exame_requisicoes, :suspeita_clinica, :string
  end
end
