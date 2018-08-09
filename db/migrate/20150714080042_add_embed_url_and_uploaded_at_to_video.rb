class AddEmbedUrlAndUploadedAtToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :embed_url,   :string
    add_column :videos, :uploaded_at, :datetime
  end
end
