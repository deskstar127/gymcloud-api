class AddIsVisibleToWorkoutTemplate < ActiveRecord::Migration
  def change
    add_column :workout_templates, :is_visible, :boolean, default: true
  end
end
