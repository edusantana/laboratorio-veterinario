class CreateFamilias < ActiveRecord::Migration[5.1]
  def change
    create_table :familias do |t|
      t.references :clinica, foreign_key: {to_table: :clinicas}, index: true

      t.timestamps
    end
  end
end
