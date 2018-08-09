class CreateWorkoutEventExercises < ActiveRecord::Migration
  def change
    create_table :workout_event_exercises do |t|
      t.references :workout_event, index: true, foreign_key: true
      t.references :workout_exercise, index: true, foreign_key: true

      t.timestamps null: true
    end
  end
end
