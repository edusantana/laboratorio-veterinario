class CreatePacientes < ActiveRecord::Migration[5.1]
  def change
    create_table :pacientes do |t|
      t.string :nome, index: true, null: false
      t.boolean :sexo
      t.string :especie
      t.date :data_nascimento
      t.string :raca
      t.boolean :vivo, default: true

      t.timestamps
    end
  end
end
