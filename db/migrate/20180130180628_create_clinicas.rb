class CreateClinicas < ActiveRecord::Migration[5.1]
  def change
    create_table :clinicas do |t|
      t.references :dono, foreign_key: {to_table: :users}, index: true
      t.string :nome

      t.timestamps
    end
  end
end
