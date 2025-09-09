class AddUrlToLivros < ActiveRecord::Migration[7.2]
  def change
    add_column :livros, :url, :string
  end
end
