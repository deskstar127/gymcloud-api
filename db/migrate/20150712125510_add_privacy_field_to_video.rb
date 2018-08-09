class AddPrivacyFieldToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :privacy, :integer, default: 1
    remove_column :videos, :published, :boolean
  end
end
