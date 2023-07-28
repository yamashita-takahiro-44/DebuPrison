class ChangeMealImagesToMealImageInMeals < ActiveRecord::Migration[7.0]
  def change
    remove_column :meals, :meal_images, :text
    add_column :meals, :meal_image, :string
  end
end
