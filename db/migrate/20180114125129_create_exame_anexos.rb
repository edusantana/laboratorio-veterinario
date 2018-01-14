class CreateExameAnexos < ActiveRecord::Migration[5.1]
  def change
    create_table :exame_anexos do |t|
      t.references :resultado, foreign_key: {to_table: :exame_resultados}, index: true
      t.attachment :anexo

      t.timestamps
    end
  end
end
