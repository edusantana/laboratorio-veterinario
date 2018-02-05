class AddFamiliaToPacientesAndTutores < ActiveRecord::Migration[5.1]
  def change
    add_reference :pacientes, :familia, foreign_key: {to_table: :familias}
    add_reference :tutores, :familia, foreign_key: {to_table: :familias}

    drop_join_table :tutores, :pacientes
  end
end
