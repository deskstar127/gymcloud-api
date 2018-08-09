class RemoveForeignKeyFromWorkoutExercise < ActiveRecord::Migration
  def change
    remove_foreign_key :workout_exercises, column: :workout_id
  end
end