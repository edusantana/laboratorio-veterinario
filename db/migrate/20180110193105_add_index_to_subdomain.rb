class AddIndexToSubdomain < ActiveRecord::Migration[5.1]
  def change
    add_index :laboratorios, :subdomain, unique: true
  end
end
