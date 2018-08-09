class AddIsMobileTutorialFinishedToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :is_mobile_tutorial_finished, :boolean
  end
end
