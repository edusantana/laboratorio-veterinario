class AddValorToExameTipos < ActiveRecord::Migration[5.1]
  def change
    add_column :exame_tipos, :valor, :float
  end
end
