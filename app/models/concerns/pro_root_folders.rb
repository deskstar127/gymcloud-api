module ProRootFolders

  extend ActiveSupport::Concern

  included do

    def library
      return [] if folders.none?
      tree = folders.root.hash_tree
      parser = lambda do |folder, branch|
        result = folder.attributes
        result[:items] = branch.map(&parser)
        items = folder.items
        result[:items] += items.flatten if items.any?
        result
      end
      tree.map(&parser)
    end

    def root_folder
      folders.find_by(name: 'Root', parent_id: nil)
    end

    def exercises_folder
      folder_for('Exercises')
    end

    def workouts_folder
      folder_for('Workout Templates')
    end

    def programs_folder
      folder_for('Program Templates')
    end

    def folder_for(name)
      root_folder.children.find_by(name: name)
    end

  end

end
