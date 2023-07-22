class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.date :start_date
      t.date :end_date
      t.integer :target_weight

      t.timestamps
    end
  end
end
