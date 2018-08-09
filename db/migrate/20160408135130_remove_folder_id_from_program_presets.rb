class RemoveFolderIdFromProgramPresets < ActiveRecord::Migration
  def change
    remove_column :program_presets, :folder_id, :integer
  end
end
