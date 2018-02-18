class ChangeDonoFromOrganizacoes < ActiveRecord::Migration[5.1]
  def change
    #change_column_null :organizacoes, :dono_id, true
    #change_column_null(table_name, column_name, null, default = nil)
    #change_column :products, :part_number, :text
    change_column_null(:organizacoes, :dono_id, true)

  end
end
