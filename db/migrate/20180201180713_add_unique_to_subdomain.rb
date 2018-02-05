class AddUniqueToSubdomain < ActiveRecord::Migration[5.1]
  def change

    add_index :organizacoes, :subdomain, unique: true

  end
end
