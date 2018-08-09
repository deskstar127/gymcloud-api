class CreateExerciseProperties < ActiveRecord::Migration
  def change
    create_table :exercise_properties do |t|
      t.references :personal_property, index: true, foreign_key: true
      t.references :workout_exercise, index: true, foreign_key: true
      t.integer :value
      t.integer :position

      t.timestamps null: false
    end
  end
end
