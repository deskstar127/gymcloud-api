class AddSourceToProgramWorkout < ActiveRecord::Migration
  def change
    add_column :program_workouts, :source_id, :integer
    add_column :program_workouts, :source_type, :string
  end
end
