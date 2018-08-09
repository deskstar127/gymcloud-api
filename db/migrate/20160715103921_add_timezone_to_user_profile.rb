class AddTimezoneToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :timezone, :string
  end
end
