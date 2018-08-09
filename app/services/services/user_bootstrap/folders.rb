module Services
module UserBootstrap

class Folders < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user]
  end

  private

  def bootstrap
    root_folder = bootstrap_root
    RootFolderCategory.all.each do |category|
      root_folder.children
        .create_with({})
        .find_or_create_by(
          name: category.name,
          user_id: @user.id
        )
    end
  end

  def bootstrap_root
    Folder
      .create_with({})
      .find_or_create_by(
        user_id: @user.id,
        name: 'Root',
        parent_id: nil
      )
  end

end

end
end
