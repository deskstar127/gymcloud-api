class CreateProgramWorkouts < ActiveRecord::Migration
  def change
    create_table :program_workouts do |t|
      t.references :workout, polymorphic: true, index: true
      t.references :program, polymorphic: true, index: true
      t.integer :workout_version
      t.text :note

      t.timestamps null: false
    end
  end
end
