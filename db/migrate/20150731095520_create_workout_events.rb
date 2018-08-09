class CreateWorkoutEvents < ActiveRecord::Migration
  def change
    create_table :workout_events do |t|
      t.references :personal_workout, index: true, foreign_key: true
      t.datetime :begins_at
      t.datetime :ends_at
      t.boolean :is_completed

      t.timestamps null: false
    end
  end
end
