class AddVideoIdToExerciseAndWorkoutTemplate < ActiveRecord::Migration
  def change
    add_column :exercises, :video_id, :integer
    add_column :workout_templates, :video_id, :integer
  end
end
