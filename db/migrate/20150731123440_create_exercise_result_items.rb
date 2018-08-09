class CreateExerciseResultItems < ActiveRecord::Migration
  def change
    create_table :exercise_result_items do |t|
      t.references :exercise_result, index: true, foreign_key: true
      t.references :exercise_property, index: true, foreign_key: true
      t.integer :value

      t.timestamps null: false
    end
  end
end
