class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.string :video_url
      t.boolean :is_public
      t.integer :author_id

      t.timestamps null: false
    end

    add_index :exercises, :author_id
  end
end
