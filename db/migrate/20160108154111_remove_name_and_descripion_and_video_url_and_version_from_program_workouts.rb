class RemoveNameAndDescripionAndVideoUrlAndVersionFromProgramWorkouts < ActiveRecord::Migration
  def change
    remove_column :program_workouts, :name, :string
    remove_column :program_workouts, :description, :text
    remove_column :program_workouts, :video_url, :string
    remove_column :program_workouts, :workout_version, :integer
  end
end
