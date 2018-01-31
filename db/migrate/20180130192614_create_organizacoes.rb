class CreateOrganizacoes < ActiveRecord::Migration[5.1]
  def change
    create_table :organizacoes do |t|
      t.references :dono, foreign_key: {to_table: :users}, index: true
      t.string :subdomain

      t.timestamps
    end
  end
end
