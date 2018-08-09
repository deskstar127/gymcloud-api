class CreateRootFolderCategories < ActiveRecord::Migration
  def change
    create_table :root_folder_categories do |t|
      t.string :klass
      t.string :name
    end
  end
end
