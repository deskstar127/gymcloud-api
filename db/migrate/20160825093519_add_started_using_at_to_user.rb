class AddStartedUsingAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :started_using_at, :date
  end
end
