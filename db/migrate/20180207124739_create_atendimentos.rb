class CreateAtendimentos < ActiveRecord::Migration[5.1]
  def change
    create_table :atendimentos do |t|
      t.text :anamnese
      t.float :peso
      t.float :temperatura_retal
      t.float :batimentos_cardiaco
      t.float :frequencia_respiratoria
      t.text :observacoes
      t.text :achados_clinicos
      t.text :exames_complementares
      t.text :diagnostico_presuntivo
      t.string :terapia_do_presuntivo
      t.text :diagnostico_definitivo
      t.text :terapia_do_definitivo
      t.references :paciente, foreign_key: {to_table: :pacientes}, null: false, index: true

      t.timestamps
    end
  end
end
