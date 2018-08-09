class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :vimeo_id
      t.string  :tmp_file
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
