class ChangeMealImagesColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :meals, :meal_images, :text
  end
end
