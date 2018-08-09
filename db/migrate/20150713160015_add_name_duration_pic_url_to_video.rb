class AddNameDurationPicUrlToVideo < ActiveRecord::Migration
  def change
    remove_column :videos, :embed,               :text
    add_column    :videos, :name,                :string
    add_column    :videos, :duration,            :integer
    add_column    :videos, :preview_picture_url, :string
  end
end
