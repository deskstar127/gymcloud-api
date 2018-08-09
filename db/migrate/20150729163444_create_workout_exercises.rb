class CreateWorkoutExercises < ActiveRecord::Migration
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, index: true, foreign_key: true
      t.references :workout_template, index: true, foreign_key: true
      t.text :note

      t.timestamps null: false
    end
  end
end
