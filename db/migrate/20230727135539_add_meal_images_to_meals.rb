class AddMealImagesToMeals < ActiveRecord::Migration[7.0]
  def change
    add_column :meals, :meal_images, :string
  end
end
