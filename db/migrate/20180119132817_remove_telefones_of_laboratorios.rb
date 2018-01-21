class RemoveTelefonesOfLaboratorios < ActiveRecord::Migration[5.1]
  def change
    remove_column :laboratorios, :telefones, :string
    remove_column :laboratorios, :endereco, :string

  end
end
