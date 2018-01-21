class CreateUnidades < ActiveRecord::Migration[5.1]
  def change
    create_table :unidades do |t|
      t.string :nome, null: false
      t.references :laboratorio, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
