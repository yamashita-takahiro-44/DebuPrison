class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise_type, null: false, foreign_key: true
      t.integer :duration
      t.integer :calories_burned
      t.datetime :date_time

      t.timestamps
    end
  end
end
