class AddColumnsToMeals < ActiveRecord::Migration[7.0]
  def change
    add_column :meals, :meal_date, :date
    add_column :meals, :meal_period, :integer
    add_column :meals, :meal_type, :integer
    add_column :meals, :meal_title_first, :string
    add_column :meals, :meal_title_second, :string
    add_column :meals, :meal_title_third, :string
    add_column :meals, :meal_weight_first, :float
    add_column :meals, :meal_weight_second, :float
    add_column :meals, :meal_weight_third, :float
    add_column :meals, :meal_calorie_first, :integer
    add_column :meals, :meal_calorie_second, :integer
    add_column :meals, :meal_calorie_third, :integer
    add_column :meals, :meal_memo, :text
  end
end
