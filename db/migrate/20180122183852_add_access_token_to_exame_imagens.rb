class AddAccessTokenToExameImagens < ActiveRecord::Migration[5.1]
  def change
    add_column :exame_imagens, :access_token, :string
  end
end
