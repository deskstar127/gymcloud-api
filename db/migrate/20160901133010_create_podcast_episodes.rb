class CreatePodcastEpisodes < ActiveRecord::Migration
  def change
    create_table :podcast_episodes do |t|
      t.string :title
      t.string :description
      t.datetime :published_at
      t.string :file
      t.integer :file_size
      t.string :content_type
      t.string :author
      t.string :duration

      t.timestamps null: false
    end
  end
end
