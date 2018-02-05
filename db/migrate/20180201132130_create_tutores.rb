class CreateTutores < ActiveRecord::Migration[5.1]
  def change
    create_table :tutores do |t|
      t.string :nome
      t.boolean :sexo
      t.references :endereco, foreign_key: {to_table: :enderecos}
      t.string :cpf
      t.string :email
      t.string :telefones

      t.timestamps
    end

    create_join_table :tutores, :pacientes do |t|
      t.index :tutor_id
      t.index :paciente_id
    end

  end
end
