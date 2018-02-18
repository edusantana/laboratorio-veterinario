class AddExperimentalToOrganizacoes < ActiveRecord::Migration[5.1]
  def change
    add_column :organizacoes, :experimental, :boolean, default: false
  end
end
