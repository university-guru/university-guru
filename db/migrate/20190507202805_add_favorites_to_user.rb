class AddFavoritesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorites, :text
  end
end
