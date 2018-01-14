class CreateExameResultados < ActiveRecord::Migration[5.1]
  def change
    create_table :exame_resultados do |t|
      t.belongs_to :requisicao, foreign_key: {to_table: :exame_requisicoes}, index: {unique: true}
      t.references :tecnico, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
