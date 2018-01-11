class CreateExameRequisicoes < ActiveRecord::Migration[5.1]
  def change
    create_table :exame_requisicoes do |t|
      t.references :tipo, foreign_key: {to_table: :exame_tipos}, null: false
      t.references :requisitante, foreign_key: {to_table: :users}, null: false
      t.string :proprietario
      t.string :nome
      t.integer :idade
      t.string :especie
      t.string :raca
      t.text :observacoes

      t.timestamps
    end
  end
end
