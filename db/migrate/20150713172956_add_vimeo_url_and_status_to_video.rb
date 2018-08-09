class AddVimeoUrlAndStatusToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :vimeo_url, :string
    add_column :videos, :status,    :string
  end
end
