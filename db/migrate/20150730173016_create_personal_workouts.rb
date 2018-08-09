class CreatePersonalWorkouts < ActiveRecord::Migration
  def change
    create_table :personal_workouts do |t|
      t.string :name
      t.text :description
      t.text :note
      t.references :workout_template, index: true, foreign_key: true
      t.integer :person_id
      t.integer :status
      t.string :video_url

      t.timestamps null: false
    end

    add_index :personal_workouts, :person_id
  end
end
