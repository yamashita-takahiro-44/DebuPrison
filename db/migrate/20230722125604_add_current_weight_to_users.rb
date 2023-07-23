class AddCurrentWeightToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_weight, :float
  end
end
