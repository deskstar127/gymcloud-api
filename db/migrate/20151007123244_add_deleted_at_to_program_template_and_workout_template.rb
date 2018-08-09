class AddDeletedAtToProgramTemplateAndWorkoutTemplate < ActiveRecord::Migration
  def change
    add_column :program_templates, :deleted_at, :datetime
    add_column :workout_templates, :deleted_at, :datetime
    add_index :program_templates, :deleted_at
    add_index :workout_templates, :deleted_at
  end
end
