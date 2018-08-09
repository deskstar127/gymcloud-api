class AddTutorialStepsToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :tutorial_steps, :text, array: true, default: []
  end
end
