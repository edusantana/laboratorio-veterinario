class RemoveDonoFromClinicas < ActiveRecord::Migration[5.1]
  def change
    remove_column :clinicas, :dono_id, :bigint
  end
end
