class CreateExameTipos < ActiveRecord::Migration[5.1]
  def change
    create_table :exame_tipos do |t|
      t.string :nome, null: false
      t.string :campos
      t.references :laboratorio, foreign_key: true, null: false
      t.timestamps
    end
  end
end
