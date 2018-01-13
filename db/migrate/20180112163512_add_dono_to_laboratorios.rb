class AddDonoToLaboratorios < ActiveRecord::Migration[5.1]
  def change
    add_reference :laboratorios, :dono, foreign_key: {to_table: :users}, index: true
  end
end
