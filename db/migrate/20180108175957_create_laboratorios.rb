class CreateLaboratorios < ActiveRecord::Migration[5.1]
  def change
    create_table :laboratorios do |t|
      t.string :nome, null: false
      t.string :subdomain, null: false

      t.timestamps
    end
  end
end
