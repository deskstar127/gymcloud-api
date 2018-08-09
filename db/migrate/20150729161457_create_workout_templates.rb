class CreateWorkoutTemplates < ActiveRecord::Migration
  def change
    create_table :workout_templates do |t|
      t.string :name
      t.text :description
      t.text :note
      t.string :video_url
      t.boolean :is_public
      t.integer :author_id

      t.timestamps null: false
    end

    add_index :workout_templates, :author_id
  end
end
