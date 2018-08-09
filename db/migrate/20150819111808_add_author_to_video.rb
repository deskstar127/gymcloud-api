class AddAuthorToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :author_id, :integer
    add_index :videos, :author_id
  end
end
