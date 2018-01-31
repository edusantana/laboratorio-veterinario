class RemoveSubdomainFromLaboratorios < ActiveRecord::Migration[5.1]
  def change
    remove_column :laboratorios, :subdomain, :string
  end
end
