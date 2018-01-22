class AddAccessTokenToExameAnexos < ActiveRecord::Migration[5.1]
  def change
    add_column :exame_anexos, :access_token, :string
  end
end
