class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :height, :integer
    add_column :users, :age_public, :boolean
    add_column :users, :height_public, :boolean
    add_column :users, :weight_public, :boolean
  end
end
