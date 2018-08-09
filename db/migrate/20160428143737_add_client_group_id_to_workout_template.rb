class AddClientGroupIdToWorkoutTemplate < ActiveRecord::Migration
  def change
    add_reference :workout_templates, :client_group, index: true, foreign_key: true
  end
end
