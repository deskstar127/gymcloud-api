class AddEmbedToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :embed, :text
  end
end
