class AddNameAndDescriptionAndVideoUrlToProgramWorkouts < ActiveRecord::Migration
  def change
    add_column :program_workouts, :name, :string
    add_column :program_workouts, :description, :text
    add_column :program_workouts, :video_url, :string
  end
end
