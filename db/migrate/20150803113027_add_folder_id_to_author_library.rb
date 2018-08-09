class AddFolderIdToAuthorLibrary < ActiveRecord::Migration

  def change
    %i{exercises workout_templates program_templates}.each do |table|
      add_column table, :folder_id, :integer
      add_index table, :folder_id
    end
  end

end
