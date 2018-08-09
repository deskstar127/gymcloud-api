class CreateExerciseResults < ActiveRecord::Migration
  def change
    create_table :exercise_results do |t|
      t.references :workout_event, index: true, foreign_key: true
      t.references :workout_exercise, index: true, foreign_key: true
      t.boolean :is_personal_best

      t.timestamps null: false
    end
  end
end
