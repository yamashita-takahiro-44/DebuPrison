class ChangeMealDetailsIdToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :meal_details, :id # 既存のUUIDのIDカラムを削除
    add_column :meal_details, :id, :primary_key # 新しい整数型のIDカラムを追加
  end
end
