class AddTelefonesToLaboratorio < ActiveRecord::Migration[5.1]
  def change
    add_column :laboratorios, :telefones, :string
  end
end
