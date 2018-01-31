class RemoveDonoFromLaboratorios < ActiveRecord::Migration[5.1]
  def change
    remove_column :laboratorios, :dono_id, :bigint
  end
end
