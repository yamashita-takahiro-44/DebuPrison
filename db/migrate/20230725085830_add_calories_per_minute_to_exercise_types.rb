class AddCaloriesPerMinuteToExerciseTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_types, :calories_per_minute, :float
  end
end
