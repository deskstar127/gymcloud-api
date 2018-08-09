class RenameRootFolderCategories < ActiveRecord::Migration

  def up
    map = {
      'Workouts' => 'Workout Templates',
      'Programs' => 'Program Templates'
    }
    rename_folders(map)
  end

  def down
    map = {
      'Workout Templates' => 'Workouts',
      'Program Templates' => 'Programs'
    }
    rename_folders(map)
  end

  def rename_folders(map)
    RootFolderCategory.all
      .select { |folder| folder.name.in?(map.keys) }
      .each { |folder| folder.name = map[folder.name]; folder.save! }
  end

end
