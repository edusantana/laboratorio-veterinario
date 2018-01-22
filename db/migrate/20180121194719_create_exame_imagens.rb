class CreateExameImagens < ActiveRecord::Migration[5.1]
  def change
    create_table :exame_imagens do |t|
      t.references :resultado, foreign_key: {to_table: :exame_resultados}, index: true
      t.attachment :imagem

      t.timestamps
    end
  end
end
