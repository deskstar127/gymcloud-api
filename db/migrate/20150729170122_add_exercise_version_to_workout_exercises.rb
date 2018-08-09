class AddExerciseVersionToWorkoutExercises < ActiveRecord::Migration

  def change
    add_column :workout_exercises, :exercise_version, :integer
  end

end
